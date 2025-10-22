/*
 * App: SQL Generation Agent
 * Package: db.migrations
 * File: 01_customer_profile_tables.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Agent
 * Date: 2025-10-21T23:58:11Z
 * Exports: customer_profile schema, postal_address, privacy_settings, customer, customer_email, customer_phone_number, v_customer_contact_summary
 * Description: Creates the normalized MySQL schema for the Customer Profile domain derived from the JSON schema specification.
 */

START TRANSACTION;

CREATE SCHEMA IF NOT EXISTS customer_profile DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE customer_profile;

-- Reference tables
CREATE TABLE IF NOT EXISTS postal_address (
    address_id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    line1            VARCHAR(255) NOT NULL,
    line2            VARCHAR(255),
    city             VARCHAR(100) NOT NULL,
    state            VARCHAR(100) NOT NULL,
    postal_code      VARCHAR(20),
    country          CHAR(2) NOT NULL,
    created_at       DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at       DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_postal_address_country CHECK (CHAR_LENGTH(country) = 2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS privacy_settings (
    privacy_settings_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    marketing_emails_enabled TINYINT(1) NOT NULL,
    two_factor_enabled      TINYINT(1) NOT NULL,
    created_at              DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at              DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Root entity
CREATE TABLE IF NOT EXISTS customer (
    customer_id         CHAR(36) NOT NULL,
    first_name          VARCHAR(255) NOT NULL,
    middle_name         VARCHAR(255),
    last_name           VARCHAR(255) NOT NULL,
    address_id          INT UNSIGNED,
    privacy_settings_id INT UNSIGNED,
    created_at          DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at          DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (customer_id),
    CONSTRAINT fk_customer_address
        FOREIGN KEY (address_id) REFERENCES postal_address(address_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_customer_privacy
        FOREIGN KEY (privacy_settings_id) REFERENCES privacy_settings(privacy_settings_id)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_customer_address_id ON customer(address_id);
CREATE INDEX idx_customer_privacy_settings_id ON customer(privacy_settings_id);
CREATE INDEX idx_customer_last_name ON customer(last_name);

-- Collections
CREATE TABLE IF NOT EXISTS customer_email (
    email_id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id  CHAR(36) NOT NULL,
    email        VARCHAR(255) NOT NULL,
    is_primary   TINYINT(1) NOT NULL DEFAULT 0,
    created_at   DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at   DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_customer_email_customer
        FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT uq_customer_email UNIQUE (customer_id, email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_customer_email_customer_id ON customer_email(customer_id);
CREATE INDEX idx_customer_email_address ON customer_email(email);

CREATE TABLE IF NOT EXISTS customer_phone_number (
    phone_id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id  CHAR(36) NOT NULL,
    phone_type   ENUM('mobile','home','work','other') NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    created_at   DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at   DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_customer_phone_customer
        FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT uq_customer_phone UNIQUE (customer_id, phone_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_customer_phone_customer_id ON customer_phone_number(customer_id);
CREATE INDEX idx_customer_phone_number ON customer_phone_number(phone_number);

-- Flattened view
CREATE OR REPLACE VIEW v_customer_contact_summary AS
SELECT
    c.customer_id,
    c.first_name,
    c.middle_name,
    c.last_name,
    pa.line1,
    pa.line2,
    pa.city,
    pa.state,
    pa.postal_code,
    pa.country,
    ps.marketing_emails_enabled,
    ps.two_factor_enabled,
    ce.email,
    ce.is_primary,
    cpn.phone_type,
    cpn.phone_number
FROM customer c
LEFT JOIN postal_address pa ON pa.address_id = c.address_id
LEFT JOIN privacy_settings ps ON ps.privacy_settings_id = c.privacy_settings_id
LEFT JOIN customer_email ce ON ce.customer_id = c.customer_id
LEFT JOIN customer_phone_number cpn ON cpn.customer_id = c.customer_id;

COMMIT;
