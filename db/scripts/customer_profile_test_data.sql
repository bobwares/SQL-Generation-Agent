/**
 * App: SQL Generation Agent
 * Package: db.scripts
 * File: customer_profile_test_data.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: gpt-5-codex
 * Date: 2025-10-22T07:38:58Z
 * Exports: Test data insert statements and smoke test query for customer_profile
 * Description: Seeds deterministic customer profile records for local testing with idempotent inserts.
 */

USE customer_profile;

START TRANSACTION;

INSERT INTO postal_address (address_id, line1, line2, city, state, postal_code, country) VALUES
    (1,  '100 Market St',       NULL,        'Springfield', 'IL', '62701', 'US'),
    (2,  '200 Oak Ave',         'Apt 2',     'Madison',     'WI', '53703', 'US'),
    (3,  '300 Pine Rd',         NULL,        'Austin',      'TX', '73301', 'US'),
    (4,  '400 Maple Ln',        NULL,        'Denver',      'CO', '80203', 'US'),
    (5,  '500 Cedar Blvd',      'Suite 5',   'Phoenix',     'AZ', '85001', 'US'),
    (6,  '600 Birch Way',       NULL,        'Portland',    'OR', '97201', 'US'),
    (7,  '700 Walnut St',       NULL,        'Boston',      'MA', '02108', 'US'),
    (8,  '800 Chestnut Dr',     NULL,        'Seattle',     'WA', '98101', 'US'),
    (9,  '900 Elm Cir',         NULL,        'Atlanta',     'GA', '30303', 'US'),
    (10, '1000 Ash Pl',         NULL,        'Miami',       'FL', '33101', 'US'),
    (11, '1100 Poplar Ct',      'Unit 11',   'Columbus',    'OH', '43004', 'US'),
    (12, '1200 Spruce St',      NULL,        'Nashville',   'TN', '37201', 'US'),
    (13, '1300 Cypress Ln',     NULL,        'Charlotte',   'NC', '28202', 'US'),
    (14, '1400 Hickory Blvd',   NULL,        'Houston',     'TX', '77002', 'US'),
    (15, '1500 Redwood Ter',    'Suite 150', 'San Diego',   'CA', '92101', 'US'),
    (16, '1600 Palm Pkwy',      NULL,        'Orlando',     'FL', '32801', 'US'),
    (17, '1700 Sycamore Way',   NULL,        'Minneapolis', 'MN', '55401', 'US'),
    (18, '1800 Alder Loop',     NULL,        'Boise',       'ID', '83702', 'US'),
    (19, '1900 Juniper Rd',     NULL,        'Santa Fe',    'NM', '87501', 'US'),
    (20, '2000 Magnolia Ave',   'Floor 2',   'Richmond',    'VA', '23219', 'US')
ON DUPLICATE KEY UPDATE
    line1 = VALUES(line1),
    line2 = VALUES(line2),
    city = VALUES(city),
    state = VALUES(state),
    postal_code = VALUES(postal_code),
    country = VALUES(country);

INSERT INTO privacy_settings (privacy_settings_id, marketing_emails_enabled, two_factor_enabled) VALUES
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
    (12, 1, 1),
    (13, 0, 1),
    (14, 1, 1),
    (15, 0, 0),
    (16, 1, 0),
    (17, 0, 1),
    (18, 1, 1),
    (19, 0, 0),
    (20, 1, 0)
ON DUPLICATE KEY UPDATE
    marketing_emails_enabled = VALUES(marketing_emails_enabled),
    two_factor_enabled = VALUES(two_factor_enabled);

INSERT INTO customer (
    customer_id,
    first_name,
    middle_name,
    last_name,
    address_id,
    privacy_settings_id
) VALUES
    ('11111111-1111-4111-8111-111111111111', 'Alice',    NULL,     'Smith',     1,  1),
    ('22222222-2222-4222-8222-222222222222', 'Brandon',  'Lee',    'Miller',    2,  2),
    ('33333333-3333-4333-8333-333333333333', 'Carla',    NULL,     'Nguyen',    3,  3),
    ('44444444-4444-4444-8444-444444444444', 'Derrick',  NULL,     'Johnson',   4,  4),
    ('55555555-5555-4555-8555-555555555555', 'Elena',    'Rae',    'Gonzalez',  5,  5),
    ('66666666-6666-4666-8666-666666666666', 'Felix',    NULL,     'Stewart',   6,  6),
    ('77777777-7777-4777-8777-777777777777', 'Grace',    'Mae',    'Thompson',  7,  7),
    ('88888888-8888-4888-8888-888888888888', 'Hector',   NULL,     'Bennett',   8,  8),
    ('99999999-9999-4999-8999-999999999999', 'Isla',     NULL,     'Reeves',    9,  9),
    ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', 'Jonah',    'Kai',    'Andrews',   10, 10),
    ('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb', 'Kara',     NULL,     'Stone',     11, 11),
    ('cccccccc-cccc-4ccc-8ccc-cccccccccccc', 'Liam',     NULL,     'Diaz',      12, 12),
    ('dddddddd-dddd-4ddd-8ddd-dddddddddddd', 'Maya',     'Lou',    'Chambers',  13, 13),
    ('eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee', 'Nolan',    NULL,     'Patel',     14, 14),
    ('ffffffff-ffff-4fff-8fff-ffffffffffff', 'Olivia',   NULL,     'Harper',    15, 15),
    ('00000000-0000-4000-8000-000000000000', 'Paul',     'J',      'Fisher',    16, 16),
    ('12345678-1234-4234-8234-123456789abc', 'Quinn',    NULL,     'Bishop',    17, 17),
    ('abcdefab-cdef-4abc-8def-abcdefabcdef', 'Riley',    NULL,     'Moreno',    18, 18),
    ('fedcba98-7654-4765-8765-fedcba987654', 'Sasha',    'Noel',   'Carver',    19, 19),
    ('13572468-2468-4246-8246-135724681357', 'Theo',     NULL,     'Lang',      20, 20)
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    middle_name = VALUES(middle_name),
    last_name = VALUES(last_name),
    address_id = VALUES(address_id),
    privacy_settings_id = VALUES(privacy_settings_id);

INSERT INTO customer_email (customer_id, email) VALUES
    ('11111111-1111-4111-8111-111111111111', 'alice.smith@example.com'),
    ('22222222-2222-4222-8222-222222222222', 'brandon.miller@example.com'),
    ('33333333-3333-4333-8333-333333333333', 'carla.nguyen@example.com'),
    ('44444444-4444-4444-8444-444444444444', 'derrick.johnson@example.com'),
    ('55555555-5555-4555-8555-555555555555', 'elena.gonzalez@example.com'),
    ('66666666-6666-4666-8666-666666666666', 'felix.stewart@example.com'),
    ('77777777-7777-4777-8777-777777777777', 'grace.thompson@example.com'),
    ('88888888-8888-4888-8888-888888888888', 'hector.bennett@example.com'),
    ('99999999-9999-4999-8999-999999999999', 'isla.reeves@example.com'),
    ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', 'jonah.andrews@example.com'),
    ('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb', 'kara.stone@example.com'),
    ('cccccccc-cccc-4ccc-8ccc-cccccccccccc', 'liam.diaz@example.com'),
    ('dddddddd-dddd-4ddd-8ddd-dddddddddddd', 'maya.chambers@example.com'),
    ('eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee', 'nolan.patel@example.com'),
    ('ffffffff-ffff-4fff-8fff-ffffffffffff', 'olivia.harper@example.com'),
    ('00000000-0000-4000-8000-000000000000', 'paul.fisher@example.com'),
    ('12345678-1234-4234-8234-123456789abc', 'quinn.bishop@example.com'),
    ('abcdefab-cdef-4abc-8def-abcdefabcdef', 'riley.moreno@example.com'),
    ('fedcba98-7654-4765-8765-fedcba987654', 'sasha.carver@example.com'),
    ('13572468-2468-4246-8246-135724681357', 'theo.lang@example.com')
ON DUPLICATE KEY UPDATE
    email = VALUES(email);

INSERT INTO customer_phone_number (customer_id, type, number) VALUES
    ('11111111-1111-4111-8111-111111111111', 'mobile', '+15550000001'),
    ('22222222-2222-4222-8222-222222222222', 'mobile', '+15550000002'),
    ('33333333-3333-4333-8333-333333333333', 'mobile', '+15550000003'),
    ('44444444-4444-4444-8444-444444444444', 'home',   '+15550000004'),
    ('55555555-5555-4555-8555-555555555555', 'mobile', '+15550000005'),
    ('66666666-6666-4666-8666-666666666666', 'work',   '+15550000006'),
    ('77777777-7777-4777-8777-777777777777', 'mobile', '+15550000007'),
    ('88888888-8888-4888-8888-888888888888', 'work',   '+15550000008'),
    ('99999999-9999-4999-8999-999999999999', 'mobile', '+15550000009'),
    ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', 'home',   '+15550000010'),
    ('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb', 'mobile', '+15550000011'),
    ('cccccccc-cccc-4ccc-8ccc-cccccccccccc', 'work',   '+15550000012'),
    ('dddddddd-dddd-4ddd-8ddd-dddddddddddd', 'mobile', '+15550000013'),
    ('eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee', 'mobile', '+15550000014'),
    ('ffffffff-ffff-4fff-8fff-ffffffffffff', 'home',   '+15550000015'),
    ('00000000-0000-4000-8000-000000000000', 'mobile', '+15550000016'),
    ('12345678-1234-4234-8234-123456789abc', 'work',   '+15550000017'),
    ('abcdefab-cdef-4abc-8def-abcdefabcdef', 'mobile', '+15550000018'),
    ('fedcba98-7654-4765-8765-fedcba987654', 'mobile', '+15550000019'),
    ('13572468-2468-4246-8246-135724681357', 'mobile', '+15550000020')
ON DUPLICATE KEY UPDATE
    type = VALUES(type),
    number = VALUES(number);

COMMIT;

-- Smoke test: expect at least 20 customers after seeding
SELECT COUNT(*) AS customer_total FROM customer;
