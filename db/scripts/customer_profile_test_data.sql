/**
 * App: SQL Generation Agent
 * Package: db.scripts
 * File: customer_profile_test_data.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Agent
 * Date: 2025-10-23T05:20:20Z
 * Exports: Idempotent seed data for customer_profile schema
 * Description: Seeds sample customer domain data and provides a smoke-test query. All timestamps reflect UTC context.
 */

SET search_path TO customer_profile, public;

-- Timestamp context: All generated_at values rely on NOW() in UTC.

INSERT INTO postal_address (address_id, line1, line2, city, state, postal_code, country)
VALUES
    (1, '100 Market St', NULL, 'Springfield', 'IL', '62701', 'US'),
    (2, '220 Oak Ave', 'Unit 4B', 'Madison', 'WI', '53703', 'US'),
    (3, '341 Pine Rd', NULL, 'Austin', 'TX', '73301', 'US'),
    (4, '482 Maple Ln', NULL, 'Denver', 'CO', '80014', 'US'),
    (5, '563 Cedar Blvd', 'Suite 5', 'Phoenix', 'AZ', '85001', 'US'),
    (6, '624 Birch Way', NULL, 'Portland', 'OR', '97035', 'US'),
    (7, '785 Walnut St', NULL, 'Boston', 'MA', '02108', 'US'),
    (8, '846 Chestnut Dr', NULL, 'Seattle', 'WA', '98101', 'US'),
    (9, '907 Elm Cir', NULL, 'Atlanta', 'GA', '30303', 'US'),
    (10, '1180 Ash Pl', NULL, 'Miami', 'FL', '33101', 'US'),
    (11, '125 Harbor View', 'Apt 12', 'San Diego', 'CA', '92101', 'US'),
    (12, '136 River Bend', NULL, 'Columbus', 'OH', '43004', 'US'),
    (13, '147 Ridge Line', NULL, 'Salt Lake City', 'UT', '84101', 'US'),
    (14, '158 Sunrise Ct', NULL, 'Raleigh', 'NC', '27601', 'US'),
    (15, '169 Sunset Blvd', 'Floor 3', 'New Orleans', 'LA', '70112', 'US'),
    (16, '170 Valley View', NULL, 'Boise', 'ID', '83702', 'US'),
    (17, '181 Glacier Way', NULL, 'Anchorage', 'AK', '99501', 'US'),
    (18, '192 Horizon Dr', NULL, 'Charlotte', 'NC', '28202', 'US'),
    (19, '203 Meadow Ln', NULL, 'Omaha', 'NE', '68102', 'US'),
    (20, '214 Brookside', NULL, 'Cleveland', 'OH', '44114', 'US')
ON CONFLICT (address_id) DO NOTHING;

INSERT INTO privacy_settings (privacy_settings_id, marketing_emails_enabled, two_factor_enabled)
VALUES
    (1, TRUE, FALSE),
    (2, FALSE, TRUE),
    (3, TRUE, TRUE),
    (4, FALSE, FALSE),
    (5, TRUE, FALSE),
    (6, FALSE, TRUE),
    (7, TRUE, TRUE),
    (8, TRUE, FALSE),
    (9, FALSE, TRUE),
    (10, TRUE, TRUE),
    (11, TRUE, FALSE),
    (12, FALSE, TRUE),
    (13, TRUE, FALSE),
    (14, FALSE, FALSE),
    (15, TRUE, TRUE),
    (16, FALSE, TRUE),
    (17, TRUE, FALSE),
    (18, TRUE, TRUE),
    (19, FALSE, FALSE),
    (20, TRUE, TRUE)
ON CONFLICT (privacy_settings_id) DO NOTHING;

INSERT INTO customer (customer_id, first_name, middle_name, last_name, address_id, privacy_settings_id)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'Alice', NULL, 'Smith', 1, 1),
    ('22222222-2222-2222-2222-222222222222', 'Benjamin', 'A', 'Lee', 2, 2),
    ('33333333-3333-3333-3333-333333333333', 'Charlotte', NULL, 'Brown', 3, 3),
    ('44444444-4444-4444-4444-444444444444', 'Daniel', 'K', 'Miller', 4, 4),
    ('55555555-5555-5555-5555-555555555555', 'Elena', NULL, 'Davis', 5, 5),
    ('66666666-6666-6666-6666-666666666666', 'Felix', NULL, 'Wilson', 6, 6),
    ('77777777-7777-7777-7777-777777777777', 'Grace', 'L', 'Taylor', 7, 7),
    ('88888888-8888-8888-8888-888888888888', 'Hugo', NULL, 'Anderson', 8, 8),
    ('99999999-9999-9999-9999-999999999999', 'Isla', NULL, 'Thomas', 9, 9),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Jacob', 'M', 'Jackson', 10, 10),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Kira', NULL, 'Nguyen', 11, 11),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Liam', 'P', 'O''Brien', 12, 12),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Maya', NULL, 'Lopez', 13, 13),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Noah', 'Q', 'Carter', 14, 14),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Olivia', NULL, 'Bennett', 15, 15),
    ('11111111-2222-3333-4444-555555555555', 'Parker', 'R', 'Shaw', 16, 16),
    ('22222222-3333-4444-5555-666666666666', 'Quinn', NULL, 'Jenkins', 17, 17),
    ('33333333-4444-5555-6666-777777777777', 'Riley', 'S', 'Morgan', 18, 18),
    ('44444444-5555-6666-7777-888888888888', 'Sofia', NULL, 'Peterson', 19, 19),
    ('55555555-6666-7777-8888-999999999999', 'Theo', 'T', 'Ramirez', 20, 20)
ON CONFLICT (customer_id) DO NOTHING;

INSERT INTO customer_email (customer_id, email, is_primary)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'alice.smith@example.com', TRUE),
    ('22222222-2222-2222-2222-222222222222', 'ben.lee@example.com', TRUE),
    ('33333333-3333-3333-3333-333333333333', 'charlotte.brown@example.com', TRUE),
    ('44444444-4444-4444-4444-444444444444', 'daniel.miller@example.com', TRUE),
    ('55555555-5555-5555-5555-555555555555', 'elena.davis@example.com', TRUE),
    ('66666666-6666-6666-6666-666666666666', 'felix.wilson@example.com', TRUE),
    ('77777777-7777-7777-7777-777777777777', 'grace.taylor@example.com', TRUE),
    ('88888888-8888-8888-8888-888888888888', 'hugo.anderson@example.com', TRUE),
    ('99999999-9999-9999-9999-999999999999', 'isla.thomas@example.com', TRUE),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'jacob.jackson@example.com', TRUE),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'kira.nguyen@example.com', TRUE),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'liam.obrien@example.com', TRUE),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'maya.lopez@example.com', TRUE),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'noah.carter@example.com', TRUE),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'olivia.bennett@example.com', TRUE),
    ('11111111-2222-3333-4444-555555555555', 'parker.shaw@example.com', TRUE),
    ('22222222-3333-4444-5555-666666666666', 'quinn.jenkins@example.com', TRUE),
    ('33333333-4444-5555-6666-777777777777', 'riley.morgan@example.com', TRUE),
    ('44444444-5555-6666-7777-888888888888', 'sofia.peterson@example.com', TRUE),
    ('55555555-6666-7777-8888-999999999999', 'theo.ramirez@example.com', TRUE)
ON CONFLICT ON CONSTRAINT customer_email_customer_email_uk DO NOTHING;

INSERT INTO customer_phone_number (customer_id, phone_type, phone_number)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'mobile', '+13125550001'),
    ('22222222-2222-2222-2222-222222222222', 'mobile', '+13125550002'),
    ('33333333-3333-3333-3333-333333333333', 'mobile', '+13125550003'),
    ('44444444-4444-4444-4444-444444444444', 'mobile', '+13125550004'),
    ('55555555-5555-5555-5555-555555555555', 'mobile', '+13125550005'),
    ('66666666-6666-6666-6666-666666666666', 'mobile', '+13125550006'),
    ('77777777-7777-7777-7777-777777777777', 'mobile', '+13125550007'),
    ('88888888-8888-8888-8888-888888888888', 'mobile', '+13125550008'),
    ('99999999-9999-9999-9999-999999999999', 'mobile', '+13125550009'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'mobile', '+13125550010'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'mobile', '+13125550011'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'mobile', '+13125550012'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'mobile', '+13125550013'),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'mobile', '+13125550014'),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'mobile', '+13125550015'),
    ('11111111-2222-3333-4444-555555555555', 'mobile', '+13125550016'),
    ('22222222-3333-4444-5555-666666666666', 'mobile', '+13125550017'),
    ('33333333-4444-5555-6666-777777777777', 'mobile', '+13125550018'),
    ('44444444-5555-6666-7777-888888888888', 'mobile', '+13125550019'),
    ('55555555-6666-7777-8888-999999999999', 'mobile', '+13125550020')
ON CONFLICT ON CONSTRAINT customer_phone_number_unique_per_customer DO NOTHING;

-- Smoke-test query
SELECT COUNT(*) AS customer_count
FROM customer;
