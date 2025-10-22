/*
 * App: SQL Generation Agent
 * Package: db.migrations
 * File: 01_customer_profile_tables.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T08:39:28Z
 * Exports: tables(customer, postal_address, privacy_settings, customer_email, customer_phone_number), view(customer_overview)
 * Description: Defines the normalized MySQL schema for customer profile data including
 *              reference tables, core entity tables, relationship tables, indexes, and
 *              a reporting view derived from the CustomerProfile JSON schema.
 */

-- Ensure the customer_profile schema exists and is active
CREATE DATABASE IF NOT EXISTS customer_profile CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE customer_profile;

-- Reference table for postal addresses
CREATE TABLE IF NOT EXISTS postal_address (
    address_id      BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    line1           VARCHAR(255) NOT NULL,
    line2           VARCHAR(255) NULL,
    city            VARCHAR(100) NOT NULL,
    state           VARCHAR(100) NOT NULL,
    postal_code     VARCHAR(20) NOT NULL,
    country         CHAR(2) NOT NULL,
    CONSTRAINT chk_postal_address_country CHECK (CHAR_LENGTH(country) = 2)
) ENGINE=InnoDB;

-- Reference table for privacy settings
CREATE TABLE IF NOT EXISTS privacy_settings (
    privacy_settings_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    marketing_emails_enabled TINYINT(1) NOT NULL,
    two_factor_enabled      TINYINT(1) NOT NULL
) ENGINE=InnoDB;

-- Root customer entity
CREATE TABLE IF NOT EXISTS customer (
    customer_id         CHAR(36) PRIMARY KEY,
    first_name          VARCHAR(255) NOT NULL,
    middle_name         VARCHAR(255) NULL,
    last_name           VARCHAR(255) NOT NULL,
    address_id          BIGINT UNSIGNED NULL,
    privacy_settings_id BIGINT UNSIGNED NOT NULL,
    CONSTRAINT fk_customer_address FOREIGN KEY (address_id)
        REFERENCES postal_address(address_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_customer_privacy_settings FOREIGN KEY (privacy_settings_id)
        REFERENCES privacy_settings(privacy_settings_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_customer_last_name ON customer (last_name);
CREATE INDEX idx_customer_address_id ON customer (address_id);
CREATE INDEX idx_customer_privacy_settings_id ON customer (privacy_settings_id);

-- One-to-many table for customer emails
CREATE TABLE IF NOT EXISTS customer_email (
    customer_email_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id       CHAR(36) NOT NULL,
    email             VARCHAR(320) NOT NULL,
    created_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer_email_customer FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT uq_customer_email UNIQUE (customer_id, email)
) ENGINE=InnoDB;

CREATE INDEX idx_customer_email_email ON customer_email (email);
CREATE INDEX idx_customer_email_customer_id ON customer_email (customer_id);

-- One-to-many table for phone numbers
CREATE TABLE IF NOT EXISTS customer_phone_number (
    customer_phone_number_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id              CHAR(36) NOT NULL,
    phone_type               ENUM('mobile', 'home', 'work', 'other') NOT NULL,
    phone_number             VARCHAR(20) NOT NULL,
    created_at               TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer_phone_customer FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT uq_customer_phone UNIQUE (customer_id, phone_number)
) ENGINE=InnoDB;

CREATE INDEX idx_customer_phone_type ON customer_phone_number (phone_type);
CREATE INDEX idx_customer_phone_customer_id ON customer_phone_number (customer_id);

-- Flattened view for reporting across the customer domain
CREATE OR REPLACE VIEW customer_overview AS
SELECT
    c.customer_id,
    c.first_name,
    c.middle_name,
    c.last_name,
    pa.line1 AS address_line1,
    pa.line2 AS address_line2,
    pa.city,
    pa.state,
    pa.postal_code,
    pa.country,
    ps.marketing_emails_enabled,
    ps.two_factor_enabled
FROM customer AS c
LEFT JOIN postal_address AS pa ON pa.address_id = c.address_id
INNER JOIN privacy_settings AS ps ON ps.privacy_settings_id = c.privacy_settings_id;

-- Index to support reporting queries on the overview view columns (materialized via base indexes)
-- Additional indexes can be added via future migrations as query patterns emerge.
