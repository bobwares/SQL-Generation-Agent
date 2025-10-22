/**
 * App: SQL-Generation-Agent
 * Package: db.scripts
 * File: customer_profile_test_data.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T19:17:11Z
 * Exports: Seed data for postal_address, privacy_settings, customer, customer_email, customer_phone_number tables
 * Description: Loads deterministic customer profile fixture data for integration and smoke testing.
 */

USE customer_profile;

START TRANSACTION;

INSERT INTO postal_address (address_id, line1, line2, city, state, postal_code, country)
VALUES
    (1, '100 Market Street', NULL, 'San Francisco', 'CA', '94105', 'US'),
    (2, '200 Oak Avenue', 'Apt 12', 'Madison', 'WI', '53703', 'US'),
    (3, '300 Pine Road', NULL, 'Austin', 'TX', '78701', 'US'),
    (4, '400 Maple Lane', NULL, 'Denver', 'CO', '80203', 'US'),
    (5, '500 Cedar Boulevard', 'Suite 5', 'Phoenix', 'AZ', '85004', 'US'),
    (6, '600 Birch Way', NULL, 'Portland', 'OR', '97205', 'US'),
    (7, '700 Walnut Street', NULL, 'Boston', 'MA', '02108', 'US'),
    (8, '800 Chestnut Drive', NULL, 'Seattle', 'WA', '98101', 'US'),
    (9, '900 Elm Circle', NULL, 'Atlanta', 'GA', '30303', 'US'),
    (10, '1000 Ash Place', NULL, 'Miami', 'FL', '33131', 'US'),
    (11, '1100 Spruce Terrace', NULL, 'Chicago', 'IL', '60601', 'US'),
    (12, '1200 Willow Court', 'Unit B', 'Columbus', 'OH', '43215', 'US'),
    (13, '1300 Poplar Trail', NULL, 'Raleigh', 'NC', '27601', 'US'),
    (14, '1400 Sycamore Blvd', NULL, 'Salt Lake City', 'UT', '84111', 'US'),
    (15, '1500 Cypress Lane', NULL, 'Tampa', 'FL', '33602', 'US'),
    (16, '1600 Redwood Drive', NULL, 'San Jose', 'CA', '95113', 'US'),
    (17, '1700 Aspen Way', NULL, 'Boulder', 'CO', '80302', 'US'),
    (18, '1800 Magnolia Street', 'Floor 3', 'New Orleans', 'LA', '70130', 'US'),
    (19, '1900 Palm Avenue', NULL, 'Los Angeles', 'CA', '90012', 'US'),
    (20, '2000 Alder Road', NULL, 'Nashville', 'TN', '37219', 'US')
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
    (4, FALSE, FALSE)
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
)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'Alice', NULL, 'Smith', 1, 1),
    ('22222222-2222-2222-2222-222222222222', 'Benjamin', 'Thomas', 'Lopez', 2, 2),
    ('33333333-3333-3333-3333-333333333333', 'Charlotte', NULL, 'Brown', 3, 3),
    ('44444444-4444-4444-4444-444444444444', 'Daniel', 'Lee', 'Miller', 4, 4),
    ('55555555-5555-5555-5555-555555555555', 'Evelyn', NULL, 'Davis', 5, 1),
    ('66666666-6666-6666-6666-666666666666', 'Felix', NULL, 'Wilson', 6, 2),
    ('77777777-7777-7777-7777-777777777777', 'Grace', 'Marie', 'Taylor', 7, 3),
    ('88888888-8888-8888-8888-888888888888', 'Henry', NULL, 'Anderson', 8, 4),
    ('99999999-9999-9999-9999-999999999999', 'Isla', NULL, 'Thomas', 9, 1),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Jack', 'Oliver', 'Jackson', 10, 2),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Katherine', NULL, 'Nguyen', 11, 3),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Liam', NULL, 'Hernandez', 12, 4),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Mia', 'Rose', 'Martinez', 13, 1),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Noah', NULL, 'Garcia', 14, 2),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Olivia', 'Grace', 'Rodriguez', 15, 3),
    ('11111111-2222-3333-4444-555555555555', 'Parker', NULL, 'Hughes', 16, 4),
    ('22222222-3333-4444-5555-666666666666', 'Quinn', NULL, 'Kim', 17, 1),
    ('33333333-4444-5555-6666-777777777777', 'Riley', 'Anne', 'Patel', 18, 2),
    ('44444444-5555-6666-7777-888888888888', 'Sophia', NULL, 'Wright', 19, 3),
    ('55555555-6666-7777-8888-999999999999', 'Theodore', 'James', 'Bennett', 20, 4)
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    middle_name = VALUES(middle_name),
    last_name = VALUES(last_name),
    address_id = VALUES(address_id),
    privacy_settings_id = VALUES(privacy_settings_id);

INSERT INTO customer_email (customer_id, email, is_primary)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'alice.smith@example.com', 1),
    ('22222222-2222-2222-2222-222222222222', 'ben.lopez@example.com', 1),
    ('33333333-3333-3333-3333-333333333333', 'charlotte.brown@example.com', 1),
    ('44444444-4444-4444-4444-444444444444', 'dan.miller@example.com', 1),
    ('55555555-5555-5555-5555-555555555555', 'evelyn.davis@example.com', 1),
    ('66666666-6666-6666-6666-666666666666', 'felix.wilson@example.com', 1),
    ('77777777-7777-7777-7777-777777777777', 'grace.taylor@example.com', 1),
    ('88888888-8888-8888-8888-888888888888', 'henry.anderson@example.com', 1),
    ('99999999-9999-9999-9999-999999999999', 'isla.thomas@example.com', 1),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'jack.jackson@example.com', 1),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'kat.nguyen@example.com', 1),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'liam.hernandez@example.com', 1),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'mia.martinez@example.com', 1),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'noah.garcia@example.com', 1),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'olivia.rodriguez@example.com', 1),
    ('11111111-2222-3333-4444-555555555555', 'parker.hughes@example.com', 1),
    ('22222222-3333-4444-5555-666666666666', 'quinn.kim@example.com', 1),
    ('33333333-4444-5555-6666-777777777777', 'riley.patel@example.com', 1),
    ('44444444-5555-6666-7777-888888888888', 'sophia.wright@example.com', 1),
    ('55555555-6666-7777-8888-999999999999', 'theodore.bennett@example.com', 1)
ON DUPLICATE KEY UPDATE
    is_primary = VALUES(is_primary);

INSERT INTO customer_phone_number (customer_id, phone_type, phone_number)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'mobile', '+14155551001'),
    ('22222222-2222-2222-2222-222222222222', 'mobile', '+16085551002'),
    ('33333333-3333-3333-3333-333333333333', 'mobile', '+15125551003'),
    ('44444444-4444-4444-4444-444444444444', 'mobile', '+13035551004'),
    ('55555555-5555-5555-5555-555555555555', 'mobile', '+16025551005'),
    ('66666666-6666-6666-6666-666666666666', 'mobile', '+15035551006'),
    ('77777777-7777-7777-7777-777777777777', 'mobile', '+16175551007'),
    ('88888888-8888-8888-8888-888888888888', 'mobile', '+12065551008'),
    ('99999999-9999-9999-9999-999999999999', 'mobile', '+14045551009'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'mobile', '+13055551010'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'mobile', '+13125551011'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'mobile', '+16145551012'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'mobile', '+19185551013'),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'mobile', '+18015551014'),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'mobile', '+18135551015'),
    ('11111111-2222-3333-4444-555555555555', 'mobile', '+14085551016'),
    ('22222222-3333-4444-5555-666666666666', 'mobile', '+13035551017'),
    ('33333333-4444-5555-6666-777777777777', 'mobile', '+15045551018'),
    ('44444444-5555-6666-7777-888888888888', 'mobile', '+13235551019'),
    ('55555555-6666-7777-8888-999999999999', 'mobile', '+16185551020')
ON DUPLICATE KEY UPDATE
    phone_type = VALUES(phone_type);

COMMIT;

-- Smoke test to validate row counts
SELECT COUNT(*) AS customer_count FROM customer;
