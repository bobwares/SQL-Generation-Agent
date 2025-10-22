/*
 * App: SQL Generation Agent
 * Package: db.scripts
 * File: customer_profile_test_data.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Agent
 * Date: 2025-10-21T23:58:11Z
 * Exports: postal_address seed data, privacy_settings seed data, customer seed data, customer_email seed data, customer_phone_number seed data
 * Description: Populates the customer_profile schema with 20 realistic customer records for testing.
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
    (6, '600 Birch Way', NULL, 'Portland', 'OR', '97035', 'US'),
    (7, '700 Walnut St', NULL, 'Boston', 'MA', '02108', 'US'),
    (8, '800 Chestnut Dr', NULL, 'Seattle', 'WA', '98101', 'US'),
    (9, '900 Elm Cir', NULL, 'Atlanta', 'GA', '30303', 'US'),
    (10, '1000 Ash Pl', NULL, 'Miami', 'FL', '33101', 'US'),
    (11, '1100 Willow Way', NULL, 'Columbus', 'OH', '43004', 'US'),
    (12, '1200 Poplar Ct', NULL, 'Nashville', 'TN', '37201', 'US'),
    (13, '1300 Cypress Pl', 'Unit 12', 'Charlotte', 'NC', '28202', 'US'),
    (14, '1400 Aspen Ter', NULL, 'Boise', 'ID', '83702', 'US'),
    (15, '1500 Redwood Dr', NULL, 'San Jose', 'CA', '95110', 'US'),
    (16, '1600 Magnolia Blvd', NULL, 'Houston', 'TX', '77002', 'US'),
    (17, '1700 Hickory St', NULL, 'Omaha', 'NE', '68102', 'US'),
    (18, '1800 Juniper Ave', NULL, 'Salt Lake City', 'UT', '84101', 'US'),
    (19, '1900 Spruce Rd', NULL, 'Minneapolis', 'MN', '55401', 'US'),
    (20, '2000 Sycamore Ln', NULL, 'Richmond', 'VA', '23219', 'US')
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
    (11, 1, 0),
    (12, 0, 1),
    (13, 1, 1),
    (14, 0, 0),
    (15, 1, 0),
    (16, 0, 1),
    (17, 1, 1),
    (18, 0, 0),
    (19, 1, 0),
    (20, 0, 1)
ON DUPLICATE KEY UPDATE
    marketing_emails_enabled = VALUES(marketing_emails_enabled),
    two_factor_enabled = VALUES(two_factor_enabled);

INSERT INTO customer (customer_id, first_name, middle_name, last_name, address_id, privacy_settings_id)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'Alice', NULL, 'Smith', 1, 1),
    ('22222222-2222-2222-2222-222222222222', 'Bob', 'J', 'Jones', 2, 2),
    ('33333333-3333-3333-3333-333333333333', 'Charlie', NULL, 'Brown', 3, 3),
    ('44444444-4444-4444-4444-444444444444', 'David', 'K', 'Miller', 4, 4),
    ('55555555-5555-5555-5555-555555555555', 'Emma', NULL, 'Davis', 5, 5),
    ('66666666-6666-6666-6666-666666666666', 'Frank', NULL, 'Wilson', 6, 6),
    ('77777777-7777-7777-7777-777777777777', 'Grace', 'L', 'Taylor', 7, 7),
    ('88888888-8888-8888-8888-888888888888', 'Hugo', NULL, 'Anderson', 8, 8),
    ('99999999-9999-9999-9999-999999999999', 'Isabel', NULL, 'Thomas', 9, 9),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Jack', 'M', 'Jackson', 10, 10),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Karen', NULL, 'Lee', 11, 11),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Liam', 'N', 'Walker', 12, 12),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Mia', NULL, 'Young', 13, 13),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Noah', NULL, 'Harris', 14, 14),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Olivia', 'P', 'Martin', 15, 15),
    ('11111111-2222-3333-4444-555555555555', 'Peter', NULL, 'Clark', 16, 16),
    ('22222222-3333-4444-5555-666666666666', 'Quinn', NULL, 'Lewis', 17, 17),
    ('33333333-4444-5555-6666-777777777777', 'Riley', 'Q', 'Hall', 18, 18),
    ('44444444-5555-6666-7777-888888888888', 'Sophia', NULL, 'Allen', 19, 19),
    ('55555555-6666-7777-8888-999999999999', 'Tyler', NULL, 'Wright', 20, 20)
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    middle_name = VALUES(middle_name),
    last_name = VALUES(last_name),
    address_id = VALUES(address_id),
    privacy_settings_id = VALUES(privacy_settings_id);

INSERT INTO customer_email (customer_id, email, is_primary)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'alice.smith@example.com', 1),
    ('22222222-2222-2222-2222-222222222222', 'bob.jones@example.com', 1),
    ('33333333-3333-3333-3333-333333333333', 'charlie.brown@example.com', 1),
    ('44444444-4444-4444-4444-444444444444', 'david.miller@example.com', 1),
    ('55555555-5555-5555-5555-555555555555', 'emma.davis@example.com', 1),
    ('66666666-6666-6666-6666-666666666666', 'frank.wilson@example.com', 1),
    ('77777777-7777-7777-7777-777777777777', 'grace.taylor@example.com', 1),
    ('88888888-8888-8888-8888-888888888888', 'hugo.anderson@example.com', 1),
    ('99999999-9999-9999-9999-999999999999', 'isabel.thomas@example.com', 1),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'jack.jackson@example.com', 1),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'karen.lee@example.com', 1),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'liam.walker@example.com', 1),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'mia.young@example.com', 1),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'noah.harris@example.com', 1),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'olivia.martin@example.com', 1),
    ('11111111-2222-3333-4444-555555555555', 'peter.clark@example.com', 1),
    ('22222222-3333-4444-5555-666666666666', 'quinn.lewis@example.com', 1),
    ('33333333-4444-5555-6666-777777777777', 'riley.hall@example.com', 1),
    ('44444444-5555-6666-7777-888888888888', 'sophia.allen@example.com', 1),
    ('55555555-6666-7777-8888-999999999999', 'tyler.wright@example.com', 1)
ON DUPLICATE KEY UPDATE
    email = VALUES(email),
    is_primary = VALUES(is_primary);

INSERT INTO customer_phone_number (customer_id, phone_type, phone_number)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'mobile', '+15550000001'),
    ('22222222-2222-2222-2222-222222222222', 'mobile', '+15550000002'),
    ('33333333-3333-3333-3333-333333333333', 'mobile', '+15550000003'),
    ('44444444-4444-4444-4444-444444444444', 'mobile', '+15550000004'),
    ('55555555-5555-5555-5555-555555555555', 'mobile', '+15550000005'),
    ('66666666-6666-6666-6666-666666666666', 'mobile', '+15550000006'),
    ('77777777-7777-7777-7777-777777777777', 'mobile', '+15550000007'),
    ('88888888-8888-8888-8888-888888888888', 'mobile', '+15550000008'),
    ('99999999-9999-9999-9999-999999999999', 'mobile', '+15550000009'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'mobile', '+15550000010'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'mobile', '+15550000011'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'mobile', '+15550000012'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'mobile', '+15550000013'),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'mobile', '+15550000014'),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'mobile', '+15550000015'),
    ('11111111-2222-3333-4444-555555555555', 'mobile', '+15550000016'),
    ('22222222-3333-4444-5555-666666666666', 'mobile', '+15550000017'),
    ('33333333-4444-5555-6666-777777777777', 'mobile', '+15550000018'),
    ('44444444-5555-6666-7777-888888888888', 'mobile', '+15550000019'),
    ('55555555-6666-7777-8888-999999999999', 'mobile', '+15550000020')
ON DUPLICATE KEY UPDATE
    phone_type = VALUES(phone_type),
    phone_number = VALUES(phone_number);

COMMIT;

-- Smoke test query
SELECT COUNT(*) AS customer_total FROM customer_profile.customer;
