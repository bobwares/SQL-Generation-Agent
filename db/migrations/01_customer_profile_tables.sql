/**
 * App: SQL-Generation-Agent
 * Package: db.migrations
 * File: 01_customer_profile_tables.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Agent
 * Date: 2025-10-20T00:09:46Z
 * Exports: customer, postal_address, privacy_settings, customer_email, customer_phone_number, customer_profile_overview
 * Description: Creates the customer_profile schema, normalized tables, constraints, indexes, and a reporting view.
 */

BEGIN;

CREATE SCHEMA IF NOT EXISTS customer_profile;
SET search_path TO customer_profile, public;

-- Reference tables
CREATE TABLE IF NOT EXISTS postal_address (
    address_id      BIGSERIAL PRIMARY KEY,
    line1           VARCHAR(255) NOT NULL,
    line2           VARCHAR(255),
    city            VARCHAR(100) NOT NULL,
    state           VARCHAR(100) NOT NULL,
    postal_code     VARCHAR(20),
    country         CHAR(2) NOT NULL,
    CHECK (char_length(trim(line1)) >= 1),
    CHECK (char_length(trim(city)) >= 1),
    CHECK (char_length(trim(state)) >= 1),
    CHECK (country ~ '^[A-Z]{2}$')
);

CREATE TABLE IF NOT EXISTS privacy_settings (
    privacy_settings_id      BIGSERIAL PRIMARY KEY,
    marketing_emails_enabled BOOLEAN NOT NULL,
    two_factor_enabled       BOOLEAN NOT NULL
);

-- Root entity
CREATE TABLE IF NOT EXISTS customer (
    customer_id         UUID PRIMARY KEY,
    first_name          VARCHAR(255) NOT NULL,
    middle_name         VARCHAR(255),
    last_name           VARCHAR(255) NOT NULL,
    address_id          BIGINT REFERENCES postal_address(address_id) ON UPDATE CASCADE ON DELETE SET NULL,
    privacy_settings_id BIGINT NOT NULL REFERENCES privacy_settings(privacy_settings_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (char_length(trim(first_name)) >= 1),
    CHECK (char_length(trim(last_name)) >= 1)
);

CREATE INDEX IF NOT EXISTS idx_customer_address_id
    ON customer (address_id);
CREATE INDEX IF NOT EXISTS idx_customer_privacy_settings_id
    ON customer (privacy_settings_id);

-- Collections
CREATE TABLE IF NOT EXISTS customer_email (
    email_id     BIGSERIAL PRIMARY KEY,
    customer_id  UUID NOT NULL REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE,
    email        VARCHAR(320) NOT NULL,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (char_length(trim(email)) >= 3),
    CHECK (email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$'),
    UNIQUE (customer_id, email)
);

CREATE INDEX IF NOT EXISTS idx_customer_email_customer_id
    ON customer_email (customer_id);
CREATE INDEX IF NOT EXISTS idx_customer_email_email
    ON customer_email (LOWER(email));

CREATE TABLE IF NOT EXISTS customer_phone_number (
    phone_id     BIGSERIAL PRIMARY KEY,
    customer_id  UUID NOT NULL REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE,
    type         VARCHAR(20) NOT NULL,
    number       VARCHAR(15) NOT NULL,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (type IN ('mobile', 'home', 'work', 'other')),
    CHECK (number ~ '^\+?[1-9]\d{1,14}$'),
    UNIQUE (customer_id, number)
);

CREATE INDEX IF NOT EXISTS idx_customer_phone_customer_id
    ON customer_phone_number (customer_id);
CREATE INDEX IF NOT EXISTS idx_customer_phone_number
    ON customer_phone_number (number);

-- Flattened reporting view
CREATE OR REPLACE VIEW customer_profile_overview AS
SELECT
    c.customer_id,
    c.first_name,
    c.middle_name,
    c.last_name,
    pa.line1      AS address_line1,
    pa.line2      AS address_line2,
    pa.city       AS address_city,
    pa.state      AS address_state,
    pa.postal_code AS address_postal_code,
    pa.country    AS address_country,
    ps.marketing_emails_enabled,
    ps.two_factor_enabled,
    coalesce(em.emails, ARRAY[]::VARCHAR[])              AS emails,
    coalesce(pn.phone_numbers, '[]'::JSONB)              AS phone_numbers,
    c.created_at,
    c.updated_at
FROM customer c
LEFT JOIN postal_address pa ON pa.address_id = c.address_id
JOIN privacy_settings ps ON ps.privacy_settings_id = c.privacy_settings_id
LEFT JOIN LATERAL (
    SELECT ARRAY_AGG(ce.email ORDER BY ce.email) AS emails
    FROM customer_email ce
    WHERE ce.customer_id = c.customer_id
) em ON TRUE
LEFT JOIN LATERAL (
    SELECT JSONB_AGG(
               JSONB_BUILD_OBJECT(
                   'type', cp.type,
                   'number', cp.number
               ) ORDER BY cp.type, cp.phone_id
           ) AS phone_numbers
    FROM customer_phone_number cp
    WHERE cp.customer_id = c.customer_id
) pn ON TRUE;

RESET search_path;
COMMIT;
