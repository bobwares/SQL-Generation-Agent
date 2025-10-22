/*
 * App: SQL Generation Agent
 * Package: db.migrations
 * File: 01_customer_profile_tables.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: gpt-5-codex
 * Date: 2025-10-22T20:17:49Z
 * Exports: Tables customer, postal_address, privacy_settings, customer_email, customer_phone_number; View customer_profile_overview
 * Description: Defines normalized MySQL tables and supporting view for the CustomerProfile domain schema.
 */

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS postal_address (
    postal_address_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    line1 VARCHAR(255) NOT NULL,
    line2 VARCHAR(255) NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country CHAR(2) NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_postal_address_postal_code (postal_code),
    KEY idx_postal_address_city_state (city, state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS privacy_settings (
    privacy_settings_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    marketing_emails_enabled TINYINT(1) NOT NULL,
    two_factor_enabled TINYINT(1) NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_privacy_settings_flags (marketing_emails_enabled, two_factor_enabled)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer (
    customer_id CHAR(36) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NOT NULL,
    postal_address_id BIGINT UNSIGNED NULL,
    privacy_settings_id BIGINT UNSIGNED NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (customer_id),
    CONSTRAINT fk_customer_postal_address FOREIGN KEY (postal_address_id)
        REFERENCES postal_address (postal_address_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_customer_privacy_settings FOREIGN KEY (privacy_settings_id)
        REFERENCES privacy_settings (privacy_settings_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    KEY idx_customer_last_name (last_name),
    KEY idx_customer_postal_address_id (postal_address_id),
    KEY idx_customer_privacy_settings_id (privacy_settings_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer_email (
    customer_email_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id CHAR(36) NOT NULL,
    email VARCHAR(320) NOT NULL,
    is_primary TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer_email_customer FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY uk_customer_email_customer_email (customer_id, email),
    KEY idx_customer_email_email (email),
    KEY idx_customer_email_is_primary (is_primary)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer_phone_number (
    customer_phone_number_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id CHAR(36) NOT NULL,
    phone_type ENUM('mobile', 'home', 'work', 'other') NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    is_primary TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer_phone_customer FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY uk_customer_phone_unique (customer_id, phone_number),
    KEY idx_customer_phone_customer (customer_id),
    KEY idx_customer_phone_number (phone_number),
    CONSTRAINT chk_customer_phone_e164 CHECK (phone_number REGEXP '^\\+?[1-9][0-9]{1,14}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE OR REPLACE VIEW customer_profile_overview AS
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
    ce.email AS primary_email,
    cpn.phone_type AS primary_phone_type,
    cpn.phone_number AS primary_phone_number,
    c.created_at,
    c.updated_at
FROM customer c
LEFT JOIN postal_address pa ON pa.postal_address_id = c.postal_address_id
LEFT JOIN privacy_settings ps ON ps.privacy_settings_id = c.privacy_settings_id
LEFT JOIN customer_email ce ON ce.customer_id = c.customer_id AND ce.is_primary = 1
LEFT JOIN customer_phone_number cpn ON cpn.customer_id = c.customer_id AND cpn.is_primary = 1;
