/*
 * App: SQL Generation Agent
 * Package: db.scripts
 * File: customer_profile_test_data.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T08:39:28Z
 * Exports: data(customer, customer_email, customer_phone_number, postal_address, privacy_settings)
 * Description: Seeds deterministic MySQL test data for the customer profile domain with
 *              idempotent inserts and a verification query.
 */

USE customer_profile;
SET time_zone = '+00:00';

START TRANSACTION;

-- Seed postal addresses
INSERT INTO postal_address (address_id, line1, line2, city, state, postal_code, country)
VALUES
    (1,  '101 Market Street',        NULL,           'Springfield',   'IL', '62701', 'US'),
    (2,  '202 Oak Avenue',           'Apt 2B',       'Madison',       'WI', '53703', 'US'),
    (3,  '303 Pine Road',            NULL,           'Austin',        'TX', '73301', 'US'),
    (4,  '404 Maple Lane',           NULL,           'Denver',        'CO', '80203', 'US'),
    (5,  '505 Cedar Boulevard',      'Suite 500',    'Phoenix',       'AZ', '85001', 'US'),
    (6,  '606 Birch Way',            NULL,           'Portland',      'OR', '97201', 'US'),
    (7,  '707 Walnut Street',        NULL,           'Boston',        'MA', '02108', 'US'),
    (8,  '808 Chestnut Drive',       NULL,           'Seattle',       'WA', '98101', 'US'),
    (9,  '909 Elm Circle',           NULL,           'Atlanta',       'GA', '30303', 'US'),
    (10, '111 Ash Place',            NULL,           'Miami',         'FL', '33101', 'US'),
    (11, '212 Willow Crescent',      'Unit 4',       'Chicago',       'IL', '60601', 'US'),
    (12, '313 Poplar Court',         NULL,           'Nashville',     'TN', '37201', 'US'),
    (13, '414 Sycamore Terrace',     NULL,           'Raleigh',       'NC', '27601', 'US'),
    (14, '515 Redwood Trail',        NULL,           'San Jose',      'CA', '95113', 'US'),
    (15, '616 Aspen Grove',          NULL,           'Salt Lake City','UT', '84101', 'US'),
    (16, '717 Spruce Crossing',      NULL,           'Boise',         'ID', '83702', 'US'),
    (17, '818 Fir Hollow',           NULL,           'Minneapolis',   'MN', '55401', 'US'),
    (18, '919 Larch Overlook',       NULL,           'Charlotte',     'NC', '28202', 'US'),
    (19, '120 Magnolia Way',         NULL,           'Richmond',      'VA', '23219', 'US'),
    (20, '221 Palm Vista',           'Floor 3',      'Los Angeles',   'CA', '90012', 'US')
ON DUPLICATE KEY UPDATE
    line1 = VALUES(line1),
    line2 = VALUES(line2),
    city = VALUES(city),
    state = VALUES(state),
    postal_code = VALUES(postal_code),
    country = VALUES(country);

-- Seed privacy settings
INSERT INTO privacy_settings (privacy_settings_id, marketing_emails_enabled, two_factor_enabled)
VALUES
    (1,  1, 0),
    (2,  0, 1),
    (3,  1, 1),
    (4,  0, 0),
    (5,  1, 0),
    (6,  0, 1),
    (7,  1, 1),
    (8,  0, 0),
    (9,  1, 0),
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

-- Seed customers
INSERT INTO customer (
    customer_id,
    first_name,
    middle_name,
    last_name,
    address_id,
    privacy_settings_id
) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Alice',      NULL,      'Garcia',     1,  1),
    ('22222222-2222-2222-2222-222222222222', 'Benjamin',   'T',       'Owens',      2,  2),
    ('33333333-3333-3333-3333-333333333333', 'Charlotte',  NULL,      'Nguyen',     3,  3),
    ('44444444-4444-4444-4444-444444444444', 'Daniel',     'A',       'Ibrahim',    4,  4),
    ('55555555-5555-5555-5555-555555555555', 'Elena',      NULL,      'Lopez',      5,  5),
    ('66666666-6666-6666-6666-666666666666', 'Felix',      NULL,      'Harris',     6,  6),
    ('77777777-7777-7777-7777-777777777777', 'Grace',      'M',       'Chen',       7,  7),
    ('88888888-8888-8888-8888-888888888888', 'Henry',      NULL,      'Patel',      8,  8),
    ('99999999-9999-9999-9999-999999999999', 'Isla',       NULL,      'Khan',       9,  9),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Jack',       'R',       'Foster',     10, 10),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Kara',       NULL,      'Silva',      11, 11),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Liam',       NULL,      'Hughes',     12, 12),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Maya',       'S',       'Bishop',     13, 13),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Noah',       NULL,      'Carter',     14, 14),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Olivia',     NULL,      'Reed',       15, 15),
    ('11111111-2222-3333-4444-555555555555', 'Parker',     NULL,      'Singh',      16, 16),
    ('22222222-3333-4444-5555-666666666666', 'Quinn',      'L',       'Bailey',     17, 17),
    ('33333333-4444-5555-6666-777777777777', 'Riley',      NULL,      'Morgan',     18, 18),
    ('44444444-5555-6666-7777-888888888888', 'Sofia',      NULL,      'Diaz',       19, 19),
    ('55555555-6666-7777-8888-999999999999', 'Theo',       'J',       'Andrews',    20, 20)
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    middle_name = VALUES(middle_name),
    last_name = VALUES(last_name),
    address_id = VALUES(address_id),
    privacy_settings_id = VALUES(privacy_settings_id);

-- Seed emails (one per customer to satisfy uniqueItems)
INSERT INTO customer_email (customer_id, email)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'alice.garcia@example.com'),
    ('22222222-2222-2222-2222-222222222222', 'ben.owens@example.com'),
    ('33333333-3333-3333-3333-333333333333', 'charlotte.nguyen@example.com'),
    ('44444444-4444-4444-4444-444444444444', 'daniel.ibrahim@example.com'),
    ('55555555-5555-5555-5555-555555555555', 'elena.lopez@example.com'),
    ('66666666-6666-6666-6666-666666666666', 'felix.harris@example.com'),
    ('77777777-7777-7777-7777-777777777777', 'grace.chen@example.com'),
    ('88888888-8888-8888-8888-888888888888', 'henry.patel@example.com'),
    ('99999999-9999-9999-9999-999999999999', 'isla.khan@example.com'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'jack.foster@example.com'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'kara.silva@example.com'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'liam.hughes@example.com'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'maya.bishop@example.com'),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'noah.carter@example.com'),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'olivia.reed@example.com'),
    ('11111111-2222-3333-4444-555555555555', 'parker.singh@example.com'),
    ('22222222-3333-4444-5555-666666666666', 'quinn.bailey@example.com'),
    ('33333333-4444-5555-6666-777777777777', 'riley.morgan@example.com'),
    ('44444444-5555-6666-7777-888888888888', 'sofia.diaz@example.com'),
    ('55555555-6666-7777-8888-999999999999', 'theo.andrews@example.com')
ON DUPLICATE KEY UPDATE
    email = VALUES(email);

-- Seed phone numbers
INSERT INTO customer_phone_number (customer_id, phone_type, phone_number)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'mobile', '+13175550001'),
    ('22222222-2222-2222-2222-222222222222', 'mobile', '+16085550002'),
    ('33333333-3333-3333-3333-333333333333', 'mobile', '+15125550003'),
    ('44444444-4444-4444-4444-444444444444', 'mobile', '+17205550004'),
    ('55555555-5555-5555-5555-555555555555', 'mobile', '+16025550005'),
    ('66666666-6666-6666-6666-666666666666', 'mobile', '+15035550006'),
    ('77777777-7777-7777-7777-777777777777', 'mobile', '+16175550007'),
    ('88888888-8888-8888-8888-888888888888', 'mobile', '+12065550008'),
    ('99999999-9999-9999-9999-999999999999', 'mobile', '+14045550009'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'mobile', '+17865550010'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'mobile', '+13125550011'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'mobile', '+16155550012'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'mobile', '+19175550013'),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'mobile', '+14085550014'),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'mobile', '+18015550015'),
    ('11111111-2222-3333-4444-555555555555', 'mobile', '+12085550016'),
    ('22222222-3333-4444-5555-666666666666', 'mobile', '+16125550017'),
    ('33333333-4444-5555-6666-777777777777', 'mobile', '+17085550018'),
    ('44444444-5555-6666-7777-888888888888', 'mobile', '+18005550019'),
    ('55555555-6666-7777-8888-999999999999', 'mobile', '+12135550020')
ON DUPLICATE KEY UPDATE
    phone_type = VALUES(phone_type),
    phone_number = VALUES(phone_number);

COMMIT;

-- Smoke test: confirm at least 20 customers exist after seed
SELECT COUNT(*) AS customer_count
FROM customer;
