# Database Artifacts

## Domain Migration

The `db/migrations/01_customer_profile_tables.sql` script provisions the MySQL schema for the customer profile domain. To apply
it locally:

1. Launch a MySQL 8.0+ instance (Docker example: `docker run --rm -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 mysql:8`).
2. Pipe the migration into the database: `mysql -h 127.0.0.1 -u root -p < db/migrations/01_customer_profile_tables.sql`.
3. Verify the view exists: `mysql -h 127.0.0.1 -u root -p -e "SHOW FULL TABLES IN customer_profile WHERE TABLE_TYPE = 'VIEW';"`.

## Test Data Seeding

The `db/scripts/customer_profile_test_data.sql` script loads deterministic sample rows. Execute it after the migration:

1. `mysql -h 127.0.0.1 -u root -p < db/scripts/customer_profile_test_data.sql`.
2. Confirm the smoke test query returns at least 20 rows: `mysql -h 127.0.0.1 -u root -p customer_profile -e "SELECT COUNT(*) FROM customer;"`.

Both scripts are idempotent and rely on InnoDB for referential integrity.
