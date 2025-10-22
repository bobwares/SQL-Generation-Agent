/**
 * App: SQL-Generation-Agent
 * Package: db.scripts
 * File: customer_profile_test_data.sql
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T01:09:09Z
 * Exports: postal_address seed data, privacy_settings seed data, customer seed data, customer_email seed data, customer_phone_number seed data
 * Description: Provides idempotent MySQL insert statements that populate the CustomerProfile domain with 20 realistic sample records and a smoke-test query.
 */

SET time_zone = '+00:00';
USE customer_profile;
START TRANSACTION;

INSERT INTO postal_address (address_id, line1, line2, city, state, postal_code, country)
VALUES
    (1, '100 Market St', NULL, 'Springfield', 'IL', '62701', 'US'),
    (2, '245 Oak Avenue', 'Apt 2B', 'Madison', 'WI', '53703', 'US'),
    (3, '18 Pine Road', NULL, 'Austin', 'TX', '73301', 'US'),
    (4, '400 Maple Lane', NULL, 'Denver', 'CO', '80203', 'US'),
    (5, '55 Cedar Boulevard', 'Suite 500', 'Phoenix', 'AZ', '85004', 'US'),
    (6, '809 Birch Way', NULL, 'Portland', 'OR', '97205', 'US'),
    (7, '712 Walnut Street', NULL, 'Boston', 'MA', '02108', 'US'),
    (8, '980 Chestnut Drive', NULL, 'Seattle', 'WA', '98101', 'US'),
    (9, '64 Elm Circle', NULL, 'Atlanta', 'GA', '30303', 'US'),
    (10, '1030 Ash Place', NULL, 'Miami', 'FL', '33101', 'US'),
    (11, '88 Riverfront Blvd', 'Unit 12', 'Cincinnati', 'OH', '45202', 'US'),
    (12, '375 Harbor View', NULL, 'San Diego', 'CA', '92101', 'US'),
    (13, '190 Sunrise Terrace', NULL, 'Nashville', 'TN', '37201', 'US'),
    (14, '27 Meadow Court', NULL, 'Minneapolis', 'MN', '55401', 'US'),
    (15, '642 Hilltop Road', NULL, 'Salt Lake City', 'UT', '84101', 'US'),
    (16, '255 Lighthouse Way', NULL, 'Charleston', 'SC', '29401', 'US'),
    (17, '70 Brookside Lane', NULL, 'Boulder', 'CO', '80302', 'US'),
    (18, '915 Willow Glen', NULL, 'Dallas', 'TX', '75201', 'US'),
    (19, '134 Sunset Drive', NULL, 'Tampa', 'FL', '33602', 'US'),
    (20, '501 Summit Street', 'Floor 3', 'Chicago', 'IL', '60601', 'US')
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
    (13, 1, 1),
    (14, 0, 1),
    (15, 1, 0),
    (16, 0, 1),
    (17, 1, 1),
    (18, 0, 0),
    (19, 1, 1),
    (20, 0, 1)
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
    ('11111111-1111-1111-1111-111111111111', 'Alice', NULL, 'Smith', 1, 1),
    ('22222222-2222-2222-2222-222222222222', 'Brandon', 'E', 'Clark', 2, 2),
    ('33333333-3333-3333-3333-333333333333', 'Carla', NULL, 'Nguyen', 3, 3),
    ('44444444-4444-4444-4444-444444444444', 'Derrick', 'K', 'Miller', 4, 4),
    ('55555555-5555-5555-5555-555555555555', 'Elena', NULL, 'Diaz', 5, 5),
    ('66666666-6666-6666-6666-666666666666', 'Farah', NULL, 'Ali', 6, 6),
    ('77777777-7777-7777-7777-777777777777', 'Gavin', 'T', 'Brooks', 7, 7),
    ('88888888-8888-8888-8888-888888888888', 'Hannah', NULL, 'Erickson', 8, 8),
    ('99999999-9999-9999-9999-999999999999', 'Ian', NULL, 'Fischer', 9, 9),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Jasmine', 'R', 'Patel', 10, 10),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Kai', NULL, 'Zimmer', 11, 11),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Lena', NULL, 'Olsen', 12, 12),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Marco', 'S', 'Romero', 13, 13),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Nia', NULL, 'Johnson', 14, 14),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Owen', NULL, 'Bennett', 15, 15),
    ('00000000-0000-0000-0000-000000000000', 'Priya', 'L', 'Chaudhary', 16, 16),
    ('12345678-1234-1234-1234-123456789abc', 'Quentin', NULL, 'Lambert', 17, 17),
    ('abcdefab-cdef-abcd-efab-cdefabcdefab', 'Rosa', NULL, 'Martinez', 18, 18),
    ('fedcba98-7654-3210-fedc-ba9876543210', 'Samuel', 'D', 'Khan', 19, 19),
    ('01928374-6574-8392-0192-837465748392', 'Talia', NULL, 'Yates', 20, 20)
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    middle_name = VALUES(middle_name),
    last_name = VALUES(last_name),
    address_id = VALUES(address_id),
    privacy_settings_id = VALUES(privacy_settings_id);

INSERT INTO customer_email (customer_id, email, is_primary)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'alice.smith@example.com', 1),
    ('22222222-2222-2222-2222-222222222222', 'brandon.clark@example.com', 1),
    ('33333333-3333-3333-3333-333333333333', 'carla.nguyen@example.com', 1),
    ('44444444-4444-4444-4444-444444444444', 'derrick.miller@example.com', 1),
    ('55555555-5555-5555-5555-555555555555', 'elena.diaz@example.com', 1),
    ('66666666-6666-6666-6666-666666666666', 'farah.ali@example.com', 1),
    ('77777777-7777-7777-7777-777777777777', 'gavin.brooks@example.com', 1),
    ('88888888-8888-8888-8888-888888888888', 'hannah.erickson@example.com', 1),
    ('99999999-9999-9999-9999-999999999999', 'ian.fischer@example.com', 1),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'jasmine.patel@example.com', 1),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'kai.zimmer@example.com', 1),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'lena.olsen@example.com', 1),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'marco.romero@example.com', 1),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'nia.johnson@example.com', 1),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'owen.bennett@example.com', 1),
    ('00000000-0000-0000-0000-000000000000', 'priya.chaudhary@example.com', 1),
    ('12345678-1234-1234-1234-123456789abc', 'quentin.lambert@example.com', 1),
    ('abcdefab-cdef-abcd-efab-cdefabcdefab', 'rosa.martinez@example.com', 1),
    ('fedcba98-7654-3210-fedc-ba9876543210', 'samuel.khan@example.com', 1),
    ('01928374-6574-8392-0192-837465748392', 'talia.yates@example.com', 1)
ON DUPLICATE KEY UPDATE
    email = VALUES(email),
    is_primary = VALUES(is_primary);

INSERT INTO customer_phone_number (customer_id, phone_type, phone_number)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'mobile', '+12175550101'),
    ('22222222-2222-2222-2222-222222222222', 'mobile', '+16085550102'),
    ('33333333-3333-3333-3333-333333333333', 'mobile', '+15125550103'),
    ('44444444-4444-4444-4444-444444444444', 'mobile', '+13035550104'),
    ('55555555-5555-5555-5555-555555555555', 'mobile', '+16025550105'),
    ('66666666-6666-6666-6666-666666666666', 'mobile', '+15035550106'),
    ('77777777-7777-7777-7777-777777777777', 'mobile', '+16175550107'),
    ('88888888-8888-8888-8888-888888888888', 'mobile', '+12065550108'),
    ('99999999-9999-9999-9999-999999999999', 'mobile', '+14045550109'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'mobile', '+13055550110'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'mobile', '+15135550111'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'mobile', '+16195550112'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'mobile', '+16155550113'),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'mobile', '+16125550114'),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'mobile', '+18015550115'),
    ('00000000-0000-0000-0000-000000000000', 'mobile', '+18435550116'),
    ('12345678-1234-1234-1234-123456789abc', 'mobile', '+13035550117'),
    ('abcdefab-cdef-abcd-efab-cdefabcdefab', 'mobile', '+14695550118'),
    ('fedcba98-7654-3210-fedc-ba9876543210', 'mobile', '+18135550119'),
    ('01928374-6574-8392-0192-837465748392', 'mobile', '+13125550120')
ON DUPLICATE KEY UPDATE
    phone_type = VALUES(phone_type),
    phone_number = VALUES(phone_number);

COMMIT;

-- Smoke test: expect at least 20 rows after seed load
SELECT COUNT(*) AS customer_count FROM customer;
