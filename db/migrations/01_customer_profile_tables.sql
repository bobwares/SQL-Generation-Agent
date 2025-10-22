/**
 * App: SQL Generation Agent
 * Package: db.migrations
 * File: db/migrations/01_customer_profile_tables.sql
 * Version: 0.1.0
 * Turns: [1]
 * Author: AI Coding Agent
 * Date: 2025-10-22T07:49:23Z
 * Exports: Tables (postal_address, privacy_settings, customer, customer_email, customer_phone_number); View (vw_customer_profile)
 * Description: Creates MySQL schema and normalized tables for the CustomerProfile domain.
 */

SET NAMES utf8mb4;
SET time_zone = '+00:00';

CREATE DATABASE IF NOT EXISTS customer_profile
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE customer_profile;

CREATE TABLE IF NOT EXISTS postal_address (
  address_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  line1 VARCHAR(255) NOT NULL,
  line2 VARCHAR(255) NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100) NOT NULL,
  postal_code VARCHAR(20) NULL,
  country CHAR(2) NOT NULL,
  PRIMARY KEY (address_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS privacy_settings (
  privacy_settings_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  marketing_emails_enabled TINYINT(1) NOT NULL,
  two_factor_enabled TINYINT(1) NOT NULL,
  PRIMARY KEY (privacy_settings_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer (
  customer_id CHAR(36) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  middle_name VARCHAR(255) NULL,
  last_name VARCHAR(255) NOT NULL,
  address_id BIGINT UNSIGNED NULL,
  privacy_settings_id BIGINT UNSIGNED NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (customer_id),
  CONSTRAINT fk_customer_address
    FOREIGN KEY (address_id)
    REFERENCES postal_address (address_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT fk_customer_privacy_settings
    FOREIGN KEY (privacy_settings_id)
    REFERENCES privacy_settings (privacy_settings_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer_email (
  customer_email_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id CHAR(36) NOT NULL,
  email VARCHAR(320) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (customer_email_id),
  CONSTRAINT fk_customer_email_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT uq_customer_email_customer
    UNIQUE (customer_id, email)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS customer_phone_number (
  customer_phone_number_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id CHAR(36) NOT NULL,
  phone_type ENUM('mobile', 'home', 'work', 'other') NOT NULL,
  phone_number VARCHAR(16) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (customer_phone_number_id),
  CONSTRAINT fk_customer_phone_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT uq_customer_phone
    UNIQUE (customer_id, phone_number)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE INDEX IF NOT EXISTS idx_customer_address_id
  ON customer (address_id);

CREATE INDEX IF NOT EXISTS idx_customer_privacy_settings_id
  ON customer (privacy_settings_id);

CREATE INDEX IF NOT EXISTS idx_customer_email_customer_id
  ON customer_email (customer_id);

CREATE INDEX IF NOT EXISTS idx_customer_phone_customer_id
  ON customer_phone_number (customer_id);

CREATE OR REPLACE VIEW vw_customer_profile AS
SELECT
  c.customer_id,
  c.first_name,
  c.middle_name,
  c.last_name,
  pa.address_id,
  pa.line1,
  pa.line2,
  pa.city,
  pa.state,
  pa.postal_code,
  pa.country,
  ps.marketing_emails_enabled,
  ps.two_factor_enabled,
  GROUP_CONCAT(DISTINCT ce.email ORDER BY ce.email SEPARATOR ', ') AS emails,
  GROUP_CONCAT(DISTINCT CONCAT(cp.phone_type, ':', cp.phone_number) ORDER BY cp.phone_type, cp.phone_number SEPARATOR ', ') AS phone_numbers,
  c.created_at,
  c.updated_at
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
  pa.address_id,
  pa.line1,
  pa.line2,
  pa.city,
  pa.state,
  pa.postal_code,
  pa.country,
  ps.marketing_emails_enabled,
  ps.two_factor_enabled,
  c.created_at,
  c.updated_at;
