/**
 * App: SQL Generation Agent
 * Package: db.scripts
 * File: db/scripts/customer_profile_test_data.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T05:33:06Z
 * Exports: Deterministic seed data for customer_profile tables
 * Description: Populates postal addresses, privacy settings, customers, emails, and phone numbers with idempotent statements.
 */

-- All timestamps and generated dates use UTC.
SET time_zone = '+00:00';

USE customer_profile;

INSERT INTO customer_profile.postal_address (postal_address_id, line1, line2, city, state, postal_code, country)
VALUES
    (1, '100 Market Street', NULL, 'Springfield', 'IL', '62701', 'US'),
    (2, '200 Oak Avenue', 'Apt 2B', 'Madison', 'WI', '53703', 'US'),
    (3, '300 Pine Road', NULL, 'Austin', 'TX', '73301', 'US'),
    (4, '400 Maple Lane', NULL, 'Denver', 'CO', '80014', 'US'),
    (5, '500 Cedar Boulevard', 'Suite 5', 'Phoenix', 'AZ', '85001', 'US'),
    (6, '600 Birch Way', NULL, 'Portland', 'OR', '97205', 'US'),
    (7, '700 Walnut Street', NULL, 'Boston', 'MA', '02108', 'US'),
    (8, '800 Chestnut Drive', NULL, 'Seattle', 'WA', '98101', 'US'),
    (9, '900 Elm Circle', NULL, 'Atlanta', 'GA', '30303', 'US'),
    (10, '1000 Ash Place', NULL, 'Miami', 'FL', '33101', 'US'),
    (11, '1100 Poplar Street', NULL, 'Columbus', 'OH', '43085', 'US'),
    (12, '1200 Willow Court', 'Unit 12', 'Charlotte', 'NC', '28202', 'US'),
    (13, '1300 Fir Terrace', NULL, 'Boise', 'ID', '83702', 'US'),
    (14, '1400 Hickory Lane', NULL, 'Nashville', 'TN', '37201', 'US'),
    (15, '1500 Sycamore Avenue', NULL, 'Omaha', 'NE', '68102', 'US'),
    (16, '1600 Larch Road', NULL, 'Minneapolis', 'MN', '55401', 'US'),
    (17, '1700 Juniper Way', NULL, 'San Diego', 'CA', '92101', 'US'),
    (18, '1800 Redwood Street', NULL, 'Salt Lake City', 'UT', '84101', 'US'),
    (19, '1900 Aspen Drive', NULL, 'Boulder', 'CO', '80302', 'US'),
    (20, '2000 Spruce Trail', NULL, 'Richmond', 'VA', '23219', 'US')
ON DUPLICATE KEY UPDATE
    line1 = VALUES(line1),
    line2 = VALUES(line2),
    city = VALUES(city),
    state = VALUES(state),
    postal_code = VALUES(postal_code),
    country = VALUES(country);

INSERT INTO customer_profile.privacy_settings (privacy_settings_id, marketing_emails_enabled, two_factor_enabled)
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

INSERT INTO customer_profile.customer (customer_id, first_name, middle_name, last_name, postal_address_id, privacy_settings_id)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'Alice', NULL, 'Smith', 1, 1),
    ('22222222-2222-2222-2222-222222222222', 'Benjamin', 'T', 'Lopez', 2, 2),
    ('33333333-3333-3333-3333-333333333333', 'Charlotte', NULL, 'Nguyen', 3, 3),
    ('44444444-4444-4444-4444-444444444444', 'Diego', 'R', 'Martinez', 4, 4),
    ('55555555-5555-5555-5555-555555555555', 'Elena', NULL, 'Khan', 5, 5),
    ('66666666-6666-6666-6666-666666666666', 'Finn', NULL, 'Anders', 6, 6),
    ('77777777-7777-7777-7777-777777777777', 'Grace', 'L', 'Baker', 7, 7),
    ('88888888-8888-8888-8888-888888888888', 'Hannah', NULL, 'Chen', 8, 8),
    ('99999999-9999-9999-9999-999999999999', 'Isaac', 'M', 'Diaz', 9, 9),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Jasmine', NULL, 'Edwards', 10, 10),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Kamal', 'N', 'Foster', 11, 11),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Lena', NULL, 'Garcia', 12, 12),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Maya', NULL, 'Hughes', 13, 13),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Noah', 'P', 'Ingram', 14, 14),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Olivia', NULL, 'Jenkins', 15, 15),
    ('11111111-aaaa-bbbb-cccc-222222222222', 'Parker', NULL, 'Kim', 16, 16),
    ('22222222-bbbb-cccc-dddd-333333333333', 'Quinn', 'S', 'Larson', 17, 17),
    ('33333333-cccc-dddd-eeee-444444444444', 'Riley', NULL, 'Mendez', 18, 18),
    ('44444444-dddd-eeee-ffff-555555555555', 'Sofia', NULL, 'Nolan', 19, 19),
    ('55555555-eeee-ffff-aaaa-666666666666', 'Tristan', 'V', 'Owens', 20, 20)
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    middle_name = VALUES(middle_name),
    last_name = VALUES(last_name),
    postal_address_id = VALUES(postal_address_id),
    privacy_settings_id = VALUES(privacy_settings_id);

INSERT INTO customer_profile.customer_email (customer_id, email)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'alice.smith@example.com'),
    ('22222222-2222-2222-2222-222222222222', 'benjamin.lopez@example.com'),
    ('33333333-3333-3333-3333-333333333333', 'charlotte.nguyen@example.com'),
    ('44444444-4444-4444-4444-444444444444', 'diego.martinez@example.com'),
    ('55555555-5555-5555-5555-555555555555', 'elena.khan@example.com'),
    ('66666666-6666-6666-6666-666666666666', 'finn.anders@example.com'),
    ('77777777-7777-7777-7777-777777777777', 'grace.baker@example.com'),
    ('88888888-8888-8888-8888-888888888888', 'hannah.chen@example.com'),
    ('99999999-9999-9999-9999-999999999999', 'isaac.diaz@example.com'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'jasmine.edwards@example.com'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'kamal.foster@example.com'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'lena.garcia@example.com'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'maya.hughes@example.com'),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'noah.ingram@example.com'),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'olivia.jenkins@example.com'),
    ('11111111-aaaa-bbbb-cccc-222222222222', 'parker.kim@example.com'),
    ('22222222-bbbb-cccc-dddd-333333333333', 'quinn.larson@example.com'),
    ('33333333-cccc-dddd-eeee-444444444444', 'riley.mendez@example.com'),
    ('44444444-dddd-eeee-ffff-555555555555', 'sofia.nolan@example.com'),
    ('55555555-eeee-ffff-aaaa-666666666666', 'tristan.owens@example.com')
ON DUPLICATE KEY UPDATE
    email = VALUES(email);

INSERT INTO customer_profile.customer_phone_number (customer_id, phone_type, phone_number)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'mobile', '+13175550001'),
    ('22222222-2222-2222-2222-222222222222', 'mobile', '+16085550002'),
    ('33333333-3333-3333-3333-333333333333', 'mobile', '+15125550003'),
    ('44444444-4444-4444-4444-444444444444', 'mobile', '+13035550004'),
    ('55555555-5555-5555-5555-555555555555', 'mobile', '+16025550005'),
    ('66666666-6666-6666-6666-666666666666', 'work', '+15035550006'),
    ('77777777-7777-7777-7777-777777777777', 'mobile', '+16175550007'),
    ('88888888-8888-8888-8888-888888888888', 'home', '+12065550008'),
    ('99999999-9999-9999-9999-999999999999', 'mobile', '+14045550009'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'mobile', '+13055550010'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'mobile', '+16145550011'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'work', '+17025550012'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'mobile', '+12085550013'),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'mobile', '+16155550014'),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'mobile', '+14065550015'),
    ('11111111-aaaa-bbbb-cccc-222222222222', 'mobile', '+16125550016'),
    ('22222222-bbbb-cccc-dddd-333333333333', 'work', '+16195550017'),
    ('33333333-cccc-dddd-eeee-444444444444', 'mobile', '+18015550018'),
    ('44444444-dddd-eeee-ffff-555555555555', 'mobile', '+13095550019'),
    ('55555555-eeee-ffff-aaaa-666666666666', 'other', '+18005550020')
ON DUPLICATE KEY UPDATE
    phone_type = VALUES(phone_type),
    phone_number = VALUES(phone_number);

-- Smoke-test query
SELECT COUNT(*) AS customer_count
FROM customer_profile.customer;
