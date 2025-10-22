/**
 * App: Customer Profile Data Service
 * Package: db.scripts
 * File: customer_profile_test_data.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T01:41:07Z
 * Exports: customer_profile sample seed data and smoke test query
 * Description: Seeds deterministic MySQL rows for addresses, privacy settings, customers, emails, and phone numbers. Re-runnable
 *              via ON DUPLICATE KEY logic and includes a smoke test query to verify row counts.
 */

SET NAMES utf8mb4;
SET time_zone = '+00:00';

USE customer_profile;

START TRANSACTION;

INSERT INTO postal_address (address_id, line1, line2, city, state, postal_code, country)
VALUES
  (1, '100 Market St', NULL, 'Springfield', 'IL', '62701', 'US'),
  (2, '200 Oak Ave', 'Apt 2', 'Madison', 'WI', '53703', 'US'),
  (3, '300 Pine Rd', NULL, 'Austin', 'TX', '73301', 'US'),
  (4, '400 Maple Ln', NULL, 'Denver', 'CO', '80014', 'US'),
  (5, '500 Cedar Blvd', 'Suite 5', 'Phoenix', 'AZ', '85001', 'US'),
  (6, '600 Birch Way', NULL, 'Portland', 'OR', '97205', 'US'),
  (7, '700 Walnut St', NULL, 'Boston', 'MA', '02108', 'US'),
  (8, '800 Chestnut Dr', NULL, 'Seattle', 'WA', '98101', 'US'),
  (9, '900 Elm Cir', NULL, 'Atlanta', 'GA', '30303', 'US'),
  (10, '1000 Ash Pl', NULL, 'Miami', 'FL', '33101', 'US'),
  (11, '1100 Willow Ln', 'Unit 11', 'Columbus', 'OH', '43085', 'US'),
  (12, '1200 Poplar St', NULL, 'Raleigh', 'NC', '27601', 'US'),
  (13, '1300 Cypress Ct', NULL, 'Sacramento', 'CA', '94203', 'US'),
  (14, '1400 Fir Trl', NULL, 'Boise', 'ID', '83702', 'US'),
  (15, '1500 Spruce Pl', NULL, 'Helena', 'MT', '59601', 'US'),
  (16, '1600 Sycamore Ave', NULL, 'Lincoln', 'NE', '68508', 'US'),
  (17, '1700 Redwood Dr', NULL, 'Santa Fe', 'NM', '87501', 'US'),
  (18, '1800 Aspen Loop', NULL, 'Boulder', 'CO', '80302', 'US'),
  (19, '1900 Sequoia Way', NULL, 'Salt Lake City', 'UT', '84101', 'US'),
  (20, '2000 Magnolia Blvd', NULL, 'Charleston', 'SC', '29401', 'US')
ON DUPLICATE KEY UPDATE
  line1 = VALUES(line1),
  line2 = VALUES(line2),
  city = VALUES(city),
  state = VALUES(state),
  postal_code = VALUES(postal_code),
  country = VALUES(country);

INSERT INTO privacy_settings (privacy_settings_id, marketing_emails_enabled, two_factor_enabled)
VALUES
  (1, 1, 0),
  (2, 0, 1),
  (3, 1, 1),
  (4, 0, 0),
  (5, 1, 0),
  (6, 0, 1),
  (7, 1, 1),
  (8, 0, 0),
  (9, 1, 0),
  (10, 0, 1),
  (11, 1, 1),
  (12, 0, 0),
  (13, 1, 0),
  (14, 0, 1),
  (15, 1, 1),
  (16, 0, 0),
  (17, 1, 0),
  (18, 0, 1),
  (19, 1, 1),
  (20, 0, 0)
ON DUPLICATE KEY UPDATE
  marketing_emails_enabled = VALUES(marketing_emails_enabled),
  two_factor_enabled = VALUES(two_factor_enabled);

INSERT INTO customer (
  customer_id,
  first_name,
  middle_name,
  last_name,
  address_id,
  privacy_settings_id,
  created_at,
  updated_at
)
VALUES
  ('00000000-0000-0000-0000-000000000001', 'Alice', NULL, 'Smith', 1, 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
  ('00000000-0000-0000-0000-000000000002', 'Benjamin', 'L', 'Turner', 2, 2, '2024-01-02 00:00:00', '2024-01-02 00:00:00'),
  ('00000000-0000-0000-0000-000000000003', 'Chloe', NULL, 'Andrews', 3, 3, '2024-01-03 00:00:00', '2024-01-03 00:00:00'),
  ('00000000-0000-0000-0000-000000000004', 'Darius', 'K', 'Miller', 4, 4, '2024-01-04 00:00:00', '2024-01-04 00:00:00'),
  ('00000000-0000-0000-0000-000000000005', 'Ella', 'M', 'Lopez', 5, 5, '2024-01-05 00:00:00', '2024-01-05 00:00:00'),
  ('00000000-0000-0000-0000-000000000006', 'Felix', NULL, 'Nguyen', 6, 6, '2024-01-06 00:00:00', '2024-01-06 00:00:00'),
  ('00000000-0000-0000-0000-000000000007', 'Grace', 'A', 'Olsen', 7, 7, '2024-01-07 00:00:00', '2024-01-07 00:00:00'),
  ('00000000-0000-0000-0000-000000000008', 'Hector', NULL, 'Perez', 8, 8, '2024-01-08 00:00:00', '2024-01-08 00:00:00'),
  ('00000000-0000-0000-0000-000000000009', 'Isla', 'B', 'Quinn', 9, 9, '2024-01-09 00:00:00', '2024-01-09 00:00:00'),
  ('00000000-0000-0000-0000-000000000010', 'Jasper', NULL, 'Reed', 10, 10, '2024-01-10 00:00:00', '2024-01-10 00:00:00'),
  ('00000000-0000-0000-0000-000000000011', 'Kira', NULL, 'Sato', 11, 11, '2024-01-11 00:00:00', '2024-01-11 00:00:00'),
  ('00000000-0000-0000-0000-000000000012', 'Landon', 'C', 'Taylor', 12, 12, '2024-01-12 00:00:00', '2024-01-12 00:00:00'),
  ('00000000-0000-0000-0000-000000000013', 'Maya', NULL, 'Underwood', 13, 13, '2024-01-13 00:00:00', '2024-01-13 00:00:00'),
  ('00000000-0000-0000-0000-000000000014', 'Noah', 'D', 'Vega', 14, 14, '2024-01-14 00:00:00', '2024-01-14 00:00:00'),
  ('00000000-0000-0000-0000-000000000015', 'Olivia', NULL, 'Wong', 15, 15, '2024-01-15 00:00:00', '2024-01-15 00:00:00'),
  ('00000000-0000-0000-0000-000000000016', 'Parker', 'E', 'Xu', 16, 16, '2024-01-16 00:00:00', '2024-01-16 00:00:00'),
  ('00000000-0000-0000-0000-000000000017', 'Quinn', NULL, 'Young', 17, 17, '2024-01-17 00:00:00', '2024-01-17 00:00:00'),
  ('00000000-0000-0000-0000-000000000018', 'Riley', 'F', 'Zimmer', 18, 18, '2024-01-18 00:00:00', '2024-01-18 00:00:00'),
  ('00000000-0000-0000-0000-000000000019', 'Sofia', NULL, 'Adams', 19, 19, '2024-01-19 00:00:00', '2024-01-19 00:00:00'),
  ('00000000-0000-0000-0000-000000000020', 'Theo', 'G', 'Baker', 20, 20, '2024-01-20 00:00:00', '2024-01-20 00:00:00')
ON DUPLICATE KEY UPDATE
  first_name = VALUES(first_name),
  middle_name = VALUES(middle_name),
  last_name = VALUES(last_name),
  address_id = VALUES(address_id),
  privacy_settings_id = VALUES(privacy_settings_id),
  updated_at = VALUES(updated_at);

INSERT INTO customer_email (email_id, customer_id, email, is_primary, created_at)
VALUES
  (1, '00000000-0000-0000-0000-000000000001', 'alice.smith@example.com', 1, '2024-02-01 00:00:00'),
  (2, '00000000-0000-0000-0000-000000000002', 'ben.turner@example.com', 1, '2024-02-02 00:00:00'),
  (3, '00000000-0000-0000-0000-000000000003', 'chloe.andrews@example.com', 1, '2024-02-03 00:00:00'),
  (4, '00000000-0000-0000-0000-000000000004', 'darius.miller@example.com', 1, '2024-02-04 00:00:00'),
  (5, '00000000-0000-0000-0000-000000000005', 'ella.lopez@example.com', 1, '2024-02-05 00:00:00'),
  (6, '00000000-0000-0000-0000-000000000006', 'felix.nguyen@example.com', 1, '2024-02-06 00:00:00'),
  (7, '00000000-0000-0000-0000-000000000007', 'grace.olsen@example.com', 1, '2024-02-07 00:00:00'),
  (8, '00000000-0000-0000-0000-000000000008', 'hector.perez@example.com', 1, '2024-02-08 00:00:00'),
  (9, '00000000-0000-0000-0000-000000000009', 'isla.quinn@example.com', 1, '2024-02-09 00:00:00'),
  (10, '00000000-0000-0000-0000-000000000010', 'jasper.reed@example.com', 1, '2024-02-10 00:00:00'),
  (11, '00000000-0000-0000-0000-000000000011', 'kira.sato@example.com', 1, '2024-02-11 00:00:00'),
  (12, '00000000-0000-0000-0000-000000000012', 'landon.taylor@example.com', 1, '2024-02-12 00:00:00'),
  (13, '00000000-0000-0000-0000-000000000013', 'maya.underwood@example.com', 1, '2024-02-13 00:00:00'),
  (14, '00000000-0000-0000-0000-000000000014', 'noah.vega@example.com', 1, '2024-02-14 00:00:00'),
  (15, '00000000-0000-0000-0000-000000000015', 'olivia.wong@example.com', 1, '2024-02-15 00:00:00'),
  (16, '00000000-0000-0000-0000-000000000016', 'parker.xu@example.com', 1, '2024-02-16 00:00:00'),
  (17, '00000000-0000-0000-0000-000000000017', 'quinn.young@example.com', 1, '2024-02-17 00:00:00'),
  (18, '00000000-0000-0000-0000-000000000018', 'riley.zimmer@example.com', 1, '2024-02-18 00:00:00'),
  (19, '00000000-0000-0000-0000-000000000019', 'sofia.adams@example.com', 1, '2024-02-19 00:00:00'),
  (20, '00000000-0000-0000-0000-000000000020', 'theo.baker@example.com', 1, '2024-02-20 00:00:00')
ON DUPLICATE KEY UPDATE
  email = VALUES(email),
  is_primary = VALUES(is_primary),
  created_at = VALUES(created_at);

INSERT INTO customer_phone_number (phone_id, customer_id, type, number, created_at)
VALUES
  (1, '00000000-0000-0000-0000-000000000001', 'mobile', '+13175550001', '2024-03-01 00:00:00'),
  (2, '00000000-0000-0000-0000-000000000002', 'mobile', '+16085550002', '2024-03-02 00:00:00'),
  (3, '00000000-0000-0000-0000-000000000003', 'mobile', '+15125550003', '2024-03-03 00:00:00'),
  (4, '00000000-0000-0000-0000-000000000004', 'mobile', '+17205550004', '2024-03-04 00:00:00'),
  (5, '00000000-0000-0000-0000-000000000005', 'mobile', '+16025550005', '2024-03-05 00:00:00'),
  (6, '00000000-0000-0000-0000-000000000006', 'mobile', '+15035550006', '2024-03-06 00:00:00'),
  (7, '00000000-0000-0000-0000-000000000007', 'mobile', '+16175550007', '2024-03-07 00:00:00'),
  (8, '00000000-0000-0000-0000-000000000008', 'mobile', '+12065550008', '2024-03-08 00:00:00'),
  (9, '00000000-0000-0000-0000-000000000009', 'mobile', '+14045550009', '2024-03-09 00:00:00'),
  (10, '00000000-0000-0000-0000-000000000010', 'mobile', '+17865550010', '2024-03-10 00:00:00'),
  (11, '00000000-0000-0000-0000-000000000011', 'mobile', '+16145550011', '2024-03-11 00:00:00'),
  (12, '00000000-0000-0000-0000-000000000012', 'mobile', '+19195550012', '2024-03-12 00:00:00'),
  (13, '00000000-0000-0000-0000-000000000013', 'mobile', '+19165550013', '2024-03-13 00:00:00'),
  (14, '00000000-0000-0000-0000-000000000014', 'mobile', '+12085550014', '2024-03-14 00:00:00'),
  (15, '00000000-0000-0000-0000-000000000015', 'mobile', '+14065550015', '2024-03-15 00:00:00'),
  (16, '00000000-0000-0000-0000-000000000016', 'mobile', '+14025550016', '2024-03-16 00:00:00'),
  (17, '00000000-0000-0000-0000-000000000017', 'mobile', '+15055550017', '2024-03-17 00:00:00'),
  (18, '00000000-0000-0000-0000-000000000018', 'mobile', '+13035550018', '2024-03-18 00:00:00'),
  (19, '00000000-0000-0000-0000-000000000019', 'mobile', '+18015550019', '2024-03-19 00:00:00'),
  (20, '00000000-0000-0000-0000-000000000020', 'mobile', '+18435550020', '2024-03-20 00:00:00')
ON DUPLICATE KEY UPDATE
  type = VALUES(type),
  number = VALUES(number),
  created_at = VALUES(created_at);

COMMIT;

-- Smoke test: ensure at least 20 customers are present
SELECT COUNT(*) AS customer_count
FROM customer;
