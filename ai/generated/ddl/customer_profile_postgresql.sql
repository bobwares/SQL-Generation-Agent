/**
 * App: SQL Generation Agent
 * Package: db/postgresql
 * File: customer_profile_postgresql.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: codex-agent
 * Date: 2025-10-20T00:21:21Z
 * Exports: phone_number_type, customer_profiles, customer_addresses, customer_emails, customer_phone_numbers, supporting constraints and triggers
 * Description: PostgreSQL DDL for the CustomerProfile domain schema including tables, constraints, and triggers derived from the provided JSON Schema.
 */

BEGIN;

-- Ensure required enumerated type exists for phone number classifications.
CREATE TYPE IF NOT EXISTS phone_number_type AS ENUM ('mobile', 'home', 'work', 'other');
COMMENT ON TYPE phone_number_type IS 'Enumerated phone number categories derived from the CustomerProfile.PhoneNumber.type definition.';

CREATE TABLE IF NOT EXISTS customer_profiles (
    id UUID PRIMARY KEY,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    last_name TEXT NOT NULL,
    marketing_emails_enabled BOOLEAN NOT NULL,
    two_factor_enabled BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_customer_profiles_first_name_min_length
        CHECK (char_length(first_name) >= 1),
    CONSTRAINT chk_customer_profiles_middle_name_min_length
        CHECK (middle_name IS NULL OR char_length(middle_name) >= 1),
    CONSTRAINT chk_customer_profiles_last_name_min_length
        CHECK (char_length(last_name) >= 1)
);

COMMENT ON TABLE customer_profiles IS 'Root table for customer profile records derived from the CustomerProfile object.';
COMMENT ON COLUMN customer_profiles.id IS 'Unique identifier for the customer profile (UUID).';
COMMENT ON COLUMN customer_profiles.first_name IS 'Customer\'s given name (minLength: 1).';
COMMENT ON COLUMN customer_profiles.middle_name IS 'Customer\'s middle name or initial (optional, minLength: 1 when provided).';
COMMENT ON COLUMN customer_profiles.last_name IS 'Customer\'s family name (minLength: 1).';
COMMENT ON COLUMN customer_profiles.marketing_emails_enabled IS 'Whether the user opts in to marketing emails.';
COMMENT ON COLUMN customer_profiles.two_factor_enabled IS 'Whether two-factor authentication is enabled.';
COMMENT ON COLUMN customer_profiles.created_at IS 'Timestamp when the customer profile row was created.';
COMMENT ON COLUMN customer_profiles.updated_at IS 'Timestamp when the customer profile row was last updated.';

CREATE OR REPLACE FUNCTION set_customer_profiles_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_customer_profiles_set_updated_at
BEFORE UPDATE ON customer_profiles
FOR EACH ROW
EXECUTE FUNCTION set_customer_profiles_updated_at();

CREATE TABLE IF NOT EXISTS customer_addresses (
    customer_id UUID PRIMARY KEY,
    line1 TEXT NOT NULL,
    line2 TEXT,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    postal_code TEXT NOT NULL,
    country CHAR(2) NOT NULL,
    CONSTRAINT fk_customer_addresses_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer_profiles (id)
        ON DELETE CASCADE,
    CONSTRAINT chk_customer_addresses_line1_min_length
        CHECK (char_length(line1) >= 1),
    CONSTRAINT chk_customer_addresses_city_min_length
        CHECK (char_length(city) >= 1),
    CONSTRAINT chk_customer_addresses_state_min_length
        CHECK (char_length(state) >= 1),
    CONSTRAINT chk_customer_addresses_postal_code_not_empty
        CHECK (char_length(postal_code) >= 1),
    CONSTRAINT chk_customer_addresses_country_length
        CHECK (char_length(country) = 2)
);

COMMENT ON TABLE customer_addresses IS 'Postal address associated with a customer profile, derived from CustomerProfile.PostalAddress.';
COMMENT ON COLUMN customer_addresses.customer_id IS 'Foreign key to customer_profiles.id (one-to-one).';
COMMENT ON COLUMN customer_addresses.line1 IS 'Street address, P.O. box, company name, c/o (minLength: 1).';
COMMENT ON COLUMN customer_addresses.line2 IS 'Apartment, suite, unit, building, floor, etc. (optional).';
COMMENT ON COLUMN customer_addresses.city IS 'City or locality (minLength: 1).';
COMMENT ON COLUMN customer_addresses.state IS 'State, province, or region (minLength: 1).';
COMMENT ON COLUMN customer_addresses.postal_code IS 'ZIP or postal code.';
COMMENT ON COLUMN customer_addresses.country IS 'ISO 3166-1 alpha-2 country code.';

CREATE TABLE IF NOT EXISTS customer_emails (
    customer_id UUID NOT NULL,
    email TEXT NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_customer_emails PRIMARY KEY (customer_id, email),
    CONSTRAINT fk_customer_emails_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer_profiles (id)
        ON DELETE CASCADE,
    CONSTRAINT chk_customer_emails_format
        CHECK (email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$')
);

COMMENT ON TABLE customer_emails IS 'Email addresses associated with a customer profile (minItems: 1, unique per customer).';
COMMENT ON COLUMN customer_emails.customer_id IS 'Foreign key to customer_profiles.id.';
COMMENT ON COLUMN customer_emails.email IS 'Customer email address (unique per customer, format=email).';
COMMENT ON COLUMN customer_emails.is_primary IS 'Indicates if the email address is the primary contact email.';
COMMENT ON COLUMN customer_emails.created_at IS 'Timestamp when the email row was created.';

CREATE UNIQUE INDEX IF NOT EXISTS uq_customer_emails_primary
ON customer_emails (customer_id)
WHERE is_primary;

CREATE TABLE IF NOT EXISTS customer_phone_numbers (
    customer_id UUID NOT NULL,
    phone_type phone_number_type NOT NULL,
    phone_number TEXT NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_customer_phone_numbers PRIMARY KEY (customer_id, phone_number),
    CONSTRAINT fk_customer_phone_numbers_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer_profiles (id)
        ON DELETE CASCADE,
    CONSTRAINT chk_customer_phone_numbers_format
        CHECK (phone_number ~ '^\\+?[1-9]\\d{1,14}$')
);

COMMENT ON TABLE customer_phone_numbers IS 'Phone numbers associated with a customer profile derived from the PhoneNumber definition.';
COMMENT ON COLUMN customer_phone_numbers.customer_id IS 'Foreign key to customer_profiles.id.';
COMMENT ON COLUMN customer_phone_numbers.phone_type IS 'Type of phone number (mobile, home, work, other).';
COMMENT ON COLUMN customer_phone_numbers.phone_number IS 'Phone number in E.164 format.';
COMMENT ON COLUMN customer_phone_numbers.is_primary IS 'Indicates if the phone number is the primary contact number.';
COMMENT ON COLUMN customer_phone_numbers.created_at IS 'Timestamp when the phone number row was created.';

CREATE UNIQUE INDEX IF NOT EXISTS uq_customer_phone_numbers_primary
ON customer_phone_numbers (customer_id)
WHERE is_primary;

CREATE INDEX IF NOT EXISTS idx_customer_phone_numbers_customer
ON customer_phone_numbers (customer_id);

CREATE OR REPLACE FUNCTION enforce_customer_email_minimum()
RETURNS TRIGGER AS $$
DECLARE
    v_customer_id UUID;
    v_email_count INTEGER;
BEGIN
    v_customer_id := COALESCE(NEW.customer_id, OLD.customer_id);

    IF NOT EXISTS (SELECT 1 FROM customer_profiles WHERE id = v_customer_id) THEN
        RETURN COALESCE(NEW, OLD);
    END IF;

    SELECT COUNT(*) INTO v_email_count
    FROM customer_emails
    WHERE customer_id = v_customer_id;

    IF v_email_count < 1 THEN
        RAISE EXCEPTION 'Customer % must have at least one email address.', v_customer_id;
    END IF;

    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_customer_emails_enforce_minimum
AFTER INSERT OR UPDATE OR DELETE ON customer_emails
FOR EACH ROW
EXECUTE FUNCTION enforce_customer_email_minimum();

CREATE OR REPLACE FUNCTION enforce_customer_profile_has_email()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM customer_emails WHERE customer_id = NEW.id
    ) THEN
        RAISE EXCEPTION 'Customer % must have at least one email address.', NEW.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE CONSTRAINT TRIGGER trg_customer_profiles_require_email
AFTER INSERT OR UPDATE ON customer_profiles
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW
EXECUTE FUNCTION enforce_customer_profile_has_email();

COMMIT;
