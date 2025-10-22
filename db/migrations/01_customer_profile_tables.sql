/**
 * App: SQL Generation Agent
 * Package: db.migrations
 * File: db/migrations/01_customer_profile_tables.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T05:33:06Z
 * Exports: Tables customer_profile.postal_address, customer_profile.privacy_settings, customer_profile.customer, customer_profile.customer_email, customer_profile.customer_phone_number; View customer_profile.vw_customer_overview
 * Description: Creates the customer_profile schema, normalized tables, supporting indexes, and a reporting view derived from the CustomerProfile JSON schema.
 */

CREATE SCHEMA IF NOT EXISTS customer_profile;

CREATE TABLE IF NOT EXISTS customer_profile.postal_address (
    postal_address_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    line1             VARCHAR(255) NOT NULL,
    line2             VARCHAR(255) NULL,
    city              VARCHAR(120) NOT NULL,
    state             VARCHAR(120) NOT NULL,
    postal_code       VARCHAR(20) NOT NULL,
    country           CHAR(2)      NOT NULL,
    CONSTRAINT chk_postal_address_country_format CHECK (country REGEXP '^[A-Z]{2}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer_profile.privacy_settings (
    privacy_settings_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    marketing_emails_enabled TINYINT(1) NOT NULL,
    two_factor_enabled       TINYINT(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer_profile.customer (
    customer_id           CHAR(36) NOT NULL,
    first_name            VARCHAR(255) NOT NULL,
    middle_name           VARCHAR(255) NULL,
    last_name             VARCHAR(255) NOT NULL,
    postal_address_id     BIGINT UNSIGNED NULL,
    privacy_settings_id   BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (customer_id),
    CONSTRAINT fk_customer_postal_address
        FOREIGN KEY (postal_address_id) REFERENCES customer_profile.postal_address (postal_address_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_customer_privacy_settings
        FOREIGN KEY (privacy_settings_id) REFERENCES customer_profile.privacy_settings (privacy_settings_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_customer_last_name (last_name),
    INDEX idx_customer_postal_address_id (postal_address_id),
    INDEX idx_customer_privacy_settings_id (privacy_settings_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer_profile.customer_email (
    customer_email_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id       CHAR(36) NOT NULL,
    email             VARCHAR(320) NOT NULL,
    created_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer_email_customer
        FOREIGN KEY (customer_id) REFERENCES customer_profile.customer (customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT uq_customer_email_customer UNIQUE (customer_id, email),
    INDEX idx_customer_email_customer_id (customer_id),
    INDEX idx_customer_email_address (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer_profile.customer_phone_number (
    customer_phone_number_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id              CHAR(36) NOT NULL,
    phone_type               ENUM('mobile', 'home', 'work', 'other') NOT NULL,
    phone_number             VARCHAR(20) NOT NULL,
    created_at               TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer_phone_customer
        FOREIGN KEY (customer_id) REFERENCES customer_profile.customer (customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT uq_customer_phone UNIQUE (customer_id, phone_number),
    INDEX idx_customer_phone_customer_id (customer_id),
    INDEX idx_customer_phone_number (phone_number),
    CONSTRAINT chk_customer_phone_number_format CHECK (phone_number REGEXP '^[+][1-9][0-9]{1,14}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE OR REPLACE VIEW customer_profile.vw_customer_overview AS
SELECT
    c.customer_id,
    c.first_name,
    c.middle_name,
    c.last_name,
    pa.line1         AS address_line1,
    pa.line2         AS address_line2,
    pa.city          AS address_city,
    pa.state         AS address_state,
    pa.postal_code   AS address_postal_code,
    pa.country       AS address_country,
    ps.marketing_emails_enabled,
    ps.two_factor_enabled,
    ce.email,
    cpn.phone_type,
    cpn.phone_number
FROM customer_profile.customer AS c
LEFT JOIN customer_profile.postal_address AS pa
    ON c.postal_address_id = pa.postal_address_id
LEFT JOIN customer_profile.privacy_settings AS ps
    ON c.privacy_settings_id = ps.privacy_settings_id
LEFT JOIN customer_profile.customer_email AS ce
    ON c.customer_id = ce.customer_id
LEFT JOIN customer_profile.customer_phone_number AS cpn
    ON c.customer_id = cpn.customer_id;
