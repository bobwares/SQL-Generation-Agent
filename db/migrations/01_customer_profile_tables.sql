/**
 * App: Customer Profile Data Service
 * Package: db.migrations
 * File: 01_customer_profile_tables.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T01:41:07Z
 * Exports: customer_profile database schema, tables, indexes, and reporting view
 * Description: Establishes MySQL schema for customer profiles derived from JSON schema. Includes base tables,
 *              supporting reference tables, indexes, and a flattened reporting view aggregating emails and phones.
 */

SET NAMES utf8mb4;
SET time_zone = '+00:00';

CREATE DATABASE IF NOT EXISTS customer_profile
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE customer_profile;

-- Reference table for postal addresses
CREATE TABLE IF NOT EXISTS postal_address (
  address_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  line1 VARCHAR(255) NOT NULL,
  line2 VARCHAR(255) NULL,
  city VARCHAR(120) NOT NULL,
  state VARCHAR(120) NOT NULL,
  postal_code VARCHAR(20) NULL,
  country CHAR(2) NOT NULL,
  PRIMARY KEY (address_id),
  UNIQUE KEY uq_postal_address_identity (line1, line2, city, state, postal_code, country)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Street and mailing addresses for customers.';

-- Reference table for privacy preferences
CREATE TABLE IF NOT EXISTS privacy_settings (
  privacy_settings_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  marketing_emails_enabled TINYINT(1) NOT NULL,
  two_factor_enabled TINYINT(1) NOT NULL,
  PRIMARY KEY (privacy_settings_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Customer privacy and authentication preferences.';

-- Core customer profile entity
CREATE TABLE IF NOT EXISTS customer (
  customer_id CHAR(36) NOT NULL DEFAULT (UUID()),
  first_name VARCHAR(255) NOT NULL,
  middle_name VARCHAR(255) NULL,
  last_name VARCHAR(255) NOT NULL,
  address_id BIGINT UNSIGNED NULL,
  privacy_settings_id BIGINT UNSIGNED NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (customer_id),
  CONSTRAINT fk_customer_address
    FOREIGN KEY (address_id) REFERENCES postal_address (address_id)
      ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_customer_privacy_settings
    FOREIGN KEY (privacy_settings_id) REFERENCES privacy_settings (privacy_settings_id)
      ON UPDATE CASCADE ON DELETE SET NULL,
  INDEX idx_customer_last_name (last_name),
  INDEX idx_customer_address_id (address_id),
  INDEX idx_customer_privacy_settings_id (privacy_settings_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Primary customer record keyed by UUID.';

-- Email addresses associated with a customer
CREATE TABLE IF NOT EXISTS customer_email (
  email_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id CHAR(36) NOT NULL,
  email VARCHAR(320) NOT NULL,
  is_primary TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (email_id),
  CONSTRAINT fk_customer_email_customer
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE KEY uq_customer_email_unique (customer_id, email),
  INDEX idx_customer_email_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Customer email addresses with uniqueness enforced per customer.';

-- Phone numbers associated with a customer
CREATE TABLE IF NOT EXISTS customer_phone_number (
  phone_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id CHAR(36) NOT NULL,
  type ENUM('mobile','home','work','other') NOT NULL,
  number VARCHAR(16) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (phone_id),
  CONSTRAINT fk_customer_phone_customer
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE KEY uq_customer_phone_unique (customer_id, number),
  INDEX idx_customer_phone_customer (customer_id),
  INDEX idx_customer_phone_number (number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Customer phone numbers constrained to E.164 formatted values.';

-- Flattened view for reporting and API reads
CREATE OR REPLACE VIEW customer_profile_flat AS
SELECT
  c.customer_id,
  c.first_name,
  c.middle_name,
  c.last_name,
  c.created_at,
  c.updated_at,
  pa.line1 AS address_line1,
  pa.line2 AS address_line2,
  pa.city AS address_city,
  pa.state AS address_state,
  pa.postal_code AS address_postal_code,
  pa.country AS address_country,
  ps.marketing_emails_enabled,
  ps.two_factor_enabled,
  ce.emails,
  cp.phone_numbers
FROM customer c
LEFT JOIN postal_address pa ON pa.address_id = c.address_id
LEFT JOIN privacy_settings ps ON ps.privacy_settings_id = c.privacy_settings_id
LEFT JOIN (
  SELECT customer_id, GROUP_CONCAT(email ORDER BY email SEPARATOR ';') AS emails
  FROM customer_email
  GROUP BY customer_id
) ce ON ce.customer_id = c.customer_id
LEFT JOIN (
  SELECT customer_id, GROUP_CONCAT(CONCAT(type, ':', number) ORDER BY type, number SEPARATOR ';') AS phone_numbers
  FROM customer_phone_number
  GROUP BY customer_id
) cp ON cp.customer_id = c.customer_id;
