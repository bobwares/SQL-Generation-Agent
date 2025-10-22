/**
 * App: SQL-Generation-Agent
 * Package: db.migrations
 * File: 01_customer_profile_tables.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T19:17:11Z
 * Exports: postal_address, privacy_settings, customer, customer_email, customer_phone_number tables; customer_profile_overview view
 * Description: Creates MySQL tables and view for the customer profile domain derived from the JSON schema.
 */

CREATE DATABASE IF NOT EXISTS customer_profile;
USE customer_profile;

CREATE TABLE IF NOT EXISTS postal_address (
    address_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    line1 VARCHAR(255) NOT NULL,
    line2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(75) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country CHAR(2) NOT NULL,
    UNIQUE KEY uq_postal_address_unique (line1, line2, city, state, postal_code, country)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS privacy_settings (
    privacy_settings_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    marketing_emails_enabled TINYINT(1) NOT NULL,
    two_factor_enabled TINYINT(1) NOT NULL,
    UNIQUE KEY uq_privacy_settings_flags (marketing_emails_enabled, two_factor_enabled)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS customer (
    customer_id CHAR(36) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255),
    last_name VARCHAR(255) NOT NULL,
    address_id BIGINT UNSIGNED,
    privacy_settings_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (customer_id),
    CONSTRAINT fk_customer_address
        FOREIGN KEY (address_id)
        REFERENCES postal_address(address_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT fk_customer_privacy
        FOREIGN KEY (privacy_settings_id)
        REFERENCES privacy_settings(privacy_settings_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_customer_last_name ON customer (last_name);
CREATE INDEX idx_customer_address_id ON customer (address_id);
CREATE INDEX idx_customer_privacy_settings_id ON customer (privacy_settings_id);

CREATE TABLE IF NOT EXISTS customer_email (
    customer_email_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id CHAR(36) NOT NULL,
    email VARCHAR(320) NOT NULL,
    is_primary TINYINT(1) NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer_email_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE KEY uq_customer_email_customer_email (customer_id, email)
) ENGINE=InnoDB;

CREATE INDEX idx_customer_email_is_primary ON customer_email (is_primary);
CREATE INDEX idx_customer_email_address ON customer_email (email);

CREATE TABLE IF NOT EXISTS customer_phone_number (
    customer_phone_number_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id CHAR(36) NOT NULL,
    phone_type ENUM('mobile', 'home', 'work', 'other') NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer_phone_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE KEY uq_customer_phone_unique (customer_id, phone_number)
) ENGINE=InnoDB;

CREATE INDEX idx_customer_phone_type ON customer_phone_number (phone_type);
CREATE INDEX idx_customer_phone_number ON customer_phone_number (phone_number);

CREATE OR REPLACE VIEW customer_profile_overview AS
SELECT
    c.customer_id,
    c.first_name,
    c.middle_name,
    c.last_name,
    c.created_at,
    c.updated_at,
    pa.address_id,
    pa.line1,
    pa.line2,
    pa.city,
    pa.state,
    pa.postal_code,
    pa.country,
    ps.privacy_settings_id,
    ps.marketing_emails_enabled,
    ps.two_factor_enabled,
    GROUP_CONCAT(DISTINCT ce.email ORDER BY ce.is_primary DESC, ce.email SEPARATOR ';') AS emails,
    GROUP_CONCAT(DISTINCT CONCAT(cp.phone_type, ':', cp.phone_number) ORDER BY cp.phone_type, cp.phone_number SEPARATOR ';') AS phone_numbers
FROM customer AS c
LEFT JOIN postal_address AS pa ON pa.address_id = c.address_id
INNER JOIN privacy_settings AS ps ON ps.privacy_settings_id = c.privacy_settings_id
LEFT JOIN customer_email AS ce ON ce.customer_id = c.customer_id
LEFT JOIN customer_phone_number AS cp ON cp.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.middle_name,
    c.last_name,
    c.created_at,
    c.updated_at,
    pa.address_id,
    pa.line1,
    pa.line2,
    pa.city,
    pa.state,
    pa.postal_code,
    pa.country,
    ps.privacy_settings_id,
    ps.marketing_emails_enabled,
    ps.two_factor_enabled;
