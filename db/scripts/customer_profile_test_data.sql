/**
 * App: SQL Generation Agent
 * Package: db.scripts
 * File: db/scripts/customer_profile_test_data.sql
 * Version: 0.1.0
 * Turns: [1]
 * Author: AI Coding Agent
 * Date: 2025-10-22T07:49:23Z
 * Exports: Seed data for postal_address, privacy_settings, customer, customer_email, customer_phone_number
 * Description: Provides idempotent seed data for the CustomerProfile domain with a smoke-test query.
 */

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
  (11, '1100 Cypress Ct', NULL, 'Columbus', 'OH', '43004', 'US'),
  (12, '1200 Willow Way', 'Unit 12', 'Nashville', 'TN', '37201', 'US'),
  (13, '1300 Poplar Dr', NULL, 'Raleigh', 'NC', '27601', 'US'),
  (14, '1400 Aspen Loop', NULL, 'Salt Lake City', 'UT', '84101', 'US'),
  (15, '1500 Fir St', NULL, 'San Diego', 'CA', '92101', 'US'),
  (16, '1600 Spruce Rd', NULL, 'Boulder', 'CO', '80302', 'US'),
  (17, '1700 Alder Ave', NULL, 'Boise', 'ID', '83702', 'US'),
  (18, '1800 Hawthorn Blvd', 'Suite 300', 'Los Angeles', 'CA', '90001', 'US'),
  (19, '1900 Magnolia Ln', NULL, 'Charleston', 'SC', '29401', 'US'),
  (20, '2000 Sequoia Pl', NULL, 'San Jose', 'CA', '95113', 'US')
ON DUPLICATE KEY UPDATE
  line1 = VALUES(line1),
  line2 = VALUES(line2),
  city = VALUES(city),
  state = VALUES(state),
  postal_code = VALUES(postal_code),
  country = VALUES(country);

INSERT INTO privacy_settings (privacy_settings_id, marketing_emails_enabled, two_factor_enabled)
VALUES
  (1, TRUE, FALSE),
  (2, FALSE, TRUE),
  (3, TRUE, TRUE),
  (4, FALSE, FALSE),
  (5, TRUE, FALSE),
  (6, FALSE, TRUE),
  (7, TRUE, TRUE),
  (8, FALSE, FALSE),
  (9, TRUE, FALSE),
  (10, FALSE, TRUE),
  (11, TRUE, TRUE),
  (12, FALSE, FALSE),
  (13, TRUE, FALSE),
  (14, FALSE, TRUE),
  (15, TRUE, TRUE),
  (16, FALSE, FALSE),
  (17, TRUE, FALSE),
  (18, FALSE, TRUE),
  (19, TRUE, TRUE),
  (20, FALSE, FALSE)
ON DUPLICATE KEY UPDATE
  marketing_emails_enabled = VALUES(marketing_emails_enabled),
  two_factor_enabled = VALUES(two_factor_enabled);

INSERT INTO customer (customer_id, first_name, middle_name, last_name, address_id, privacy_settings_id)
VALUES
  ('11111111-1111-1111-1111-111111111111', 'Alice', NULL, 'Smith', 1, 1),
  ('22222222-2222-2222-2222-222222222222', 'Bob', 'J', 'Jones', 2, 2),
  ('33333333-3333-3333-3333-333333333333', 'Charlie', NULL, 'Brown', 3, 3),
  ('44444444-4444-4444-4444-444444444444', 'Dana', 'K', 'Miller', 4, 4),
  ('55555555-5555-5555-5555-555555555555', 'Emma', NULL, 'Davis', 5, 5),
  ('66666666-6666-6666-6666-666666666666', 'Frank', NULL, 'Wilson', 6, 6),
  ('77777777-7777-7777-7777-777777777777', 'Grace', 'L', 'Taylor', 7, 7),
  ('88888888-8888-8888-8888-888888888888', 'Hugo', NULL, 'Anderson', 8, 8),
  ('99999999-9999-9999-9999-999999999999', 'Ivy', NULL, 'Thomas', 9, 9),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Jack', 'M', 'Jackson', 10, 10),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Karen', NULL, 'White', 11, 11),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Leo', 'N', 'Martin', 12, 12),
  ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Mia', NULL, 'Clark', 13, 13),
  ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Noah', 'O', 'Walker', 14, 14),
  ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Olivia', NULL, 'Young', 15, 15),
  ('00000000-0000-0000-0000-000000000000', 'Paul', 'Q', 'Hall', 16, 16),
  ('12121212-1212-1212-1212-121212121212', 'Quinn', NULL, 'Adams', 17, 17),
  ('34343434-3434-3434-3434-343434343434', 'Riley', 'S', 'Bennett', 18, 18),
  ('56565656-5656-5656-5656-565656565656', 'Sofia', NULL, 'Coleman', 19, 19),
  ('78787878-7878-7878-7878-787878787878', 'Tyler', 'U', 'Diaz', 20, 20)
ON DUPLICATE KEY UPDATE
  first_name = VALUES(first_name),
  middle_name = VALUES(middle_name),
  last_name = VALUES(last_name),
  address_id = VALUES(address_id),
  privacy_settings_id = VALUES(privacy_settings_id);

INSERT INTO customer_email (customer_id, email)
VALUES
  ('11111111-1111-1111-1111-111111111111', 'alice.smith@example.com'),
  ('22222222-2222-2222-2222-222222222222', 'bob.jones@example.com'),
  ('33333333-3333-3333-3333-333333333333', 'charlie.brown@example.com'),
  ('44444444-4444-4444-4444-444444444444', 'dana.miller@example.com'),
  ('55555555-5555-5555-5555-555555555555', 'emma.davis@example.com'),
  ('66666666-6666-6666-6666-666666666666', 'frank.wilson@example.com'),
  ('77777777-7777-7777-7777-777777777777', 'grace.taylor@example.com'),
  ('88888888-8888-8888-8888-888888888888', 'hugo.anderson@example.com'),
  ('99999999-9999-9999-9999-999999999999', 'ivy.thomas@example.com'),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'jack.jackson@example.com'),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'karen.white@example.com'),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'leo.martin@example.com'),
  ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'mia.clark@example.com'),
  ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'noah.walker@example.com'),
  ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'olivia.young@example.com'),
  ('00000000-0000-0000-0000-000000000000', 'paul.hall@example.com'),
  ('12121212-1212-1212-1212-121212121212', 'quinn.adams@example.com'),
  ('34343434-3434-3434-3434-343434343434', 'riley.bennett@example.com'),
  ('56565656-5656-5656-5656-565656565656', 'sofia.coleman@example.com'),
  ('78787878-7878-7878-7878-787878787878', 'tyler.diaz@example.com')
ON DUPLICATE KEY UPDATE
  email = VALUES(email);

INSERT INTO customer_phone_number (customer_id, phone_type, phone_number)
VALUES
  ('11111111-1111-1111-1111-111111111111', 'mobile', '+15555550101'),
  ('22222222-2222-2222-2222-222222222222', 'mobile', '+15555550102'),
  ('33333333-3333-3333-3333-333333333333', 'mobile', '+15555550103'),
  ('44444444-4444-4444-4444-444444444444', 'mobile', '+15555550104'),
  ('55555555-5555-5555-5555-555555555555', 'mobile', '+15555550105'),
  ('66666666-6666-6666-6666-666666666666', 'mobile', '+15555550106'),
  ('77777777-7777-7777-7777-777777777777', 'mobile', '+15555550107'),
  ('88888888-8888-8888-8888-888888888888', 'mobile', '+15555550108'),
  ('99999999-9999-9999-9999-999999999999', 'mobile', '+15555550109'),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'mobile', '+15555550110'),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'mobile', '+15555550111'),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'mobile', '+15555550112'),
  ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'mobile', '+15555550113'),
  ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'mobile', '+15555550114'),
  ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'mobile', '+15555550115'),
  ('00000000-0000-0000-0000-000000000000', 'mobile', '+15555550116'),
  ('12121212-1212-1212-1212-121212121212', 'mobile', '+15555550117'),
  ('34343434-3434-3434-3434-343434343434', 'mobile', '+15555550118'),
  ('56565656-5656-5656-5656-565656565656', 'mobile', '+15555550119'),
  ('78787878-7878-7878-7878-787878787878', 'mobile', '+15555550120')
ON DUPLICATE KEY UPDATE
  phone_type = VALUES(phone_type),
  phone_number = VALUES(phone_number);

COMMIT;

-- Smoke test query to verify at least 20 customers are present
SELECT COUNT(*) AS customer_count
FROM customer;
