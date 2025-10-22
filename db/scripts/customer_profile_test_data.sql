/*
 * App: SQL Generation Agent
 * Package: db.scripts
 * File: customer_profile_test_data.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: gpt-5-codex
 * Date: 2025-10-22T20:17:49Z
 * Exports: Seed data for postal_address, privacy_settings, customer, customer_email, customer_phone_number
 * Description: Populates the CustomerProfile domain tables with deterministic seed data and smoke-test query for MySQL.
 */

START TRANSACTION;

INSERT INTO postal_address (postal_address_id, line1, line2, city, state, postal_code, country)
VALUES
    (1, '100 Market St', NULL, 'Springfield', 'IL', '62701', 'US'),
    (2, '200 Oak Ave', 'Apt 2', 'Madison', 'WI', '53703', 'US'),
    (3, '300 Pine Rd', NULL, 'Austin', 'TX', '73301', 'US'),
    (4, '400 Maple Ln', NULL, 'Denver', 'CO', '80014', 'US'),
    (5, '500 Cedar Blvd', 'Suite 5', 'Phoenix', 'AZ', '85001', 'US'),
    (6, '600 Birch Way', NULL, 'Portland', 'OR', '97035', 'US'),
    (7, '700 Walnut St', NULL, 'Boston', 'MA', '02108', 'US'),
    (8, '800 Chestnut Dr', NULL, 'Seattle', 'WA', '98101', 'US'),
    (9, '900 Elm Cir', NULL, 'Atlanta', 'GA', '30303', 'US'),
    (10, '1000 Ash Pl', NULL, 'Miami', 'FL', '33101', 'US'),
    (11, '1100 Cedar St', NULL, 'Columbus', 'OH', '43004', 'US'),
    (12, '1200 Pine Ave', 'Unit 12', 'Chicago', 'IL', '60601', 'US'),
    (13, '1300 Lake Dr', NULL, 'Minneapolis', 'MN', '55401', 'US'),
    (14, '1400 Ridge Rd', NULL, 'Salt Lake City', 'UT', '84101', 'US'),
    (15, '1500 Brook St', NULL, 'Nashville', 'TN', '37201', 'US'),
    (16, '1600 Canyon Blvd', NULL, 'Boulder', 'CO', '80302', 'US'),
    (17, '1700 Summit Ave', NULL, 'Dallas', 'TX', '75201', 'US'),
    (18, '1800 River Rd', NULL, 'Richmond', 'VA', '23219', 'US'),
    (19, '1900 Harbor Ln', NULL, 'San Diego', 'CA', '92101', 'US'),
    (20, '2000 Orchard St', NULL, 'Boise', 'ID', '83702', 'US')
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
    (4, 0, 0)
ON DUPLICATE KEY UPDATE
    marketing_emails_enabled = VALUES(marketing_emails_enabled),
    two_factor_enabled = VALUES(two_factor_enabled);

INSERT INTO customer (
    customer_id,
    first_name,
    middle_name,
    last_name,
    postal_address_id,
    privacy_settings_id)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'Alice', NULL, 'Smith', 1, 1),
    ('22222222-2222-2222-2222-222222222222', 'Bob', 'J', 'Jones', 2, 2),
    ('33333333-3333-3333-3333-333333333333', 'Charlie', NULL, 'Brown', 3, 3),
    ('44444444-4444-4444-4444-444444444444', 'David', 'K', 'Miller', 4, 4),
    ('55555555-5555-5555-5555-555555555555', 'Emma', NULL, 'Davis', 5, 1),
    ('66666666-6666-6666-6666-666666666666', 'Frank', NULL, 'Wilson', 6, 2),
    ('77777777-7777-7777-7777-777777777777', 'Grace', 'L', 'Taylor', 7, 3),
    ('88888888-8888-8888-8888-888888888888', 'Hugo', NULL, 'Anderson', 8, 4),
    ('99999999-9999-9999-9999-999999999999', 'Isabel', NULL, 'Thomas', 9, 1),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Jack', 'M', 'Jackson', 10, 2),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Karen', NULL, 'Nguyen', 11, 3),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Leo', 'N', 'Martinez', 12, 4),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Mia', NULL, 'Lopez', 13, 1),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Noah', NULL, 'Perez', 14, 2),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Olivia', 'P', 'Kim', 15, 3),
    ('10101010-1010-1010-1010-101010101010', 'Paul', NULL, 'Rivera', 16, 4),
    ('20202020-2020-2020-2020-202020202020', 'Quinn', NULL, 'Hernandez', 17, 1),
    ('30303030-3030-3030-3030-303030303030', 'Riley', NULL, 'Patel', 18, 2),
    ('40404040-4040-4040-4040-404040404040', 'Sofia', 'Q', 'Gupta', 19, 3),
    ('50505050-5050-5050-5050-505050505050', 'Troy', NULL, 'Bennett', 20, 4)
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    middle_name = VALUES(middle_name),
    last_name = VALUES(last_name),
    postal_address_id = VALUES(postal_address_id),
    privacy_settings_id = VALUES(privacy_settings_id);

INSERT INTO customer_email (
    customer_email_id,
    customer_id,
    email,
    is_primary)
VALUES
    (1, '11111111-1111-1111-1111-111111111111', 'alice.smith@example.com', 1),
    (2, '22222222-2222-2222-2222-222222222222', 'bob.jones@example.com', 1),
    (3, '33333333-3333-3333-3333-333333333333', 'charlie.brown@example.com', 1),
    (4, '44444444-4444-4444-4444-444444444444', 'david.miller@example.com', 1),
    (5, '55555555-5555-5555-5555-555555555555', 'emma.davis@example.com', 1),
    (6, '66666666-6666-6666-6666-666666666666', 'frank.wilson@example.com', 1),
    (7, '77777777-7777-7777-7777-777777777777', 'grace.taylor@example.com', 1),
    (8, '88888888-8888-8888-8888-888888888888', 'hugo.anderson@example.com', 1),
    (9, '99999999-9999-9999-9999-999999999999', 'isabel.thomas@example.com', 1),
    (10, 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'jack.jackson@example.com', 1),
    (11, 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'karen.nguyen@example.com', 1),
    (12, 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'leo.martinez@example.com', 1),
    (13, 'dddddddd-dddd-dddd-dddd-dddddddddddd', 'mia.lopez@example.com', 1),
    (14, 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'noah.perez@example.com', 1),
    (15, 'ffffffff-ffff-ffff-ffff-ffffffffffff', 'olivia.kim@example.com', 1),
    (16, '10101010-1010-1010-1010-101010101010', 'paul.rivera@example.com', 1),
    (17, '20202020-2020-2020-2020-202020202020', 'quinn.hernandez@example.com', 1),
    (18, '30303030-3030-3030-3030-303030303030', 'riley.patel@example.com', 1),
    (19, '40404040-4040-4040-4040-404040404040', 'sofia.gupta@example.com', 1),
    (20, '50505050-5050-5050-5050-505050505050', 'troy.bennett@example.com', 1)
ON DUPLICATE KEY UPDATE
    email = VALUES(email),
    is_primary = VALUES(is_primary);

INSERT INTO customer_phone_number (
    customer_phone_number_id,
    customer_id,
    phone_type,
    phone_number,
    is_primary)
VALUES
    (1, '11111111-1111-1111-1111-111111111111', 'mobile', '+15555550101', 1),
    (2, '22222222-2222-2222-2222-222222222222', 'mobile', '+15555550102', 1),
    (3, '33333333-3333-3333-3333-333333333333', 'mobile', '+15555550103', 1),
    (4, '44444444-4444-4444-4444-444444444444', 'mobile', '+15555550104', 1),
    (5, '55555555-5555-5555-5555-555555555555', 'mobile', '+15555550105', 1),
    (6, '66666666-6666-6666-6666-666666666666', 'mobile', '+15555550106', 1),
    (7, '77777777-7777-7777-7777-777777777777', 'mobile', '+15555550107', 1),
    (8, '88888888-8888-8888-8888-888888888888', 'mobile', '+15555550108', 1),
    (9, '99999999-9999-9999-9999-999999999999', 'mobile', '+15555550109', 1),
    (10, 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'mobile', '+15555550110', 1),
    (11, 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'mobile', '+15555550111', 1),
    (12, 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'mobile', '+15555550112', 1),
    (13, 'dddddddd-dddd-dddd-dddd-dddddddddddd', 'mobile', '+15555550113', 1),
    (14, 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'mobile', '+15555550114', 1),
    (15, 'ffffffff-ffff-ffff-ffff-ffffffffffff', 'mobile', '+15555550115', 1),
    (16, '10101010-1010-1010-1010-101010101010', 'mobile', '+15555550116', 1),
    (17, '20202020-2020-2020-2020-202020202020', 'mobile', '+15555550117', 1),
    (18, '30303030-3030-3030-3030-303030303030', 'mobile', '+15555550118', 1),
    (19, '40404040-4040-4040-4040-404040404040', 'mobile', '+15555550119', 1),
    (20, '50505050-5050-5050-5050-505050505050', 'mobile', '+15555550120', 1)
ON DUPLICATE KEY UPDATE
    phone_type = VALUES(phone_type),
    phone_number = VALUES(phone_number),
    is_primary = VALUES(is_primary);

COMMIT;

-- Smoke-test query: expect 20 rows after first load
SELECT COUNT(*) AS customer_count FROM customer;
