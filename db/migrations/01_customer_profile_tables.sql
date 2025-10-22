/**
 * App: SQL Generation Agent
 * Package: db.migrations
 * File: 01_customer_profile_tables.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: gpt-5-codex
 * Date: 2025-10-22T07:38:58Z
 * Exports: Tables, indexes, and view for the customer_profile domain
 * Description: Creates MySQL schema objects for customer profiles, contacts, and privacy preferences.
 */

CREATE DATABASE IF NOT EXISTS customer_profile
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE customer_profile;

CREATE TABLE IF NOT EXISTS postal_address (
    address_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    line1 VARCHAR(255) NOT NULL,
    line2 VARCHAR(255) NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NULL,
    country CHAR(2) NOT NULL,
    CONSTRAINT chk_postal_address_country CHECK (CHAR_LENGTH(country) = 2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS privacy_settings (
    privacy_settings_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    marketing_emails_enabled TINYINT(1) NOT NULL,
    two_factor_enabled TINYINT(1) NOT NULL,
    CONSTRAINT chk_privacy_settings_marketing CHECK (marketing_emails_enabled IN (0, 1)),
    CONSTRAINT chk_privacy_settings_two_factor CHECK (two_factor_enabled IN (0, 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer (
    customer_id CHAR(36) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255) NULL,
    last_name VARCHAR(255) NOT NULL,
    address_id BIGINT UNSIGNED NULL,
    privacy_settings_id BIGINT UNSIGNED NULL,
    PRIMARY KEY (customer_id),
    CONSTRAINT fk_customer_address
        FOREIGN KEY (address_id)
        REFERENCES postal_address (address_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_customer_privacy_settings
        FOREIGN KEY (privacy_settings_id)
        REFERENCES privacy_settings (privacy_settings_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_customer_address_id ON customer (address_id);
CREATE INDEX idx_customer_privacy_settings_id ON customer (privacy_settings_id);
CREATE INDEX idx_customer_last_name ON customer (last_name);

CREATE TABLE IF NOT EXISTS customer_email (
    email_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id CHAR(36) NOT NULL,
    email VARCHAR(320) NOT NULL,
    CONSTRAINT fk_customer_email_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT uq_customer_email UNIQUE (customer_id, email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_customer_email_customer_id ON customer_email (customer_id);
CREATE INDEX idx_customer_email_email ON customer_email (email);

CREATE TABLE IF NOT EXISTS customer_phone_number (
    phone_number_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id CHAR(36) NOT NULL,
    type ENUM('mobile', 'home', 'work', 'other') NOT NULL,
    number VARCHAR(15) NOT NULL,
    CONSTRAINT fk_customer_phone_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT uq_customer_phone UNIQUE (customer_id, number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_customer_phone_customer_id ON customer_phone_number (customer_id);
CREATE INDEX idx_customer_phone_type ON customer_phone_number (type);

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
    GROUP_CONCAT(DISTINCT ce.email ORDER BY ce.email SEPARATOR ', ') AS emails,
    GROUP_CONCAT(DISTINCT CONCAT(cp.type, ':', cp.number) ORDER BY cp.type, cp.number SEPARATOR ', ') AS phone_numbers
FROM customer AS c
LEFT JOIN postal_address AS pa ON pa.address_id = c.address_id
LEFT JOIN privacy_settings AS ps ON ps.privacy_settings_id = c.privacy_settings_id
LEFT JOIN customer_email AS ce ON ce.customer_id = c.customer_id
LEFT JOIN customer_phone_number AS cp ON cp.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.middle_name,
    c.last_name,
    pa.address_id,
    ps.privacy_settings_id;
