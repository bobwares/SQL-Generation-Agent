<!--
App: SQL Generation Agent
Package: db
File: README.md
Version: 0.1.0
Turns: 1
Author: AI Agent
Date: 2025-10-21T23:58:11Z
Exports: Domain Migration documentation
Description: Describes how to run the customer profile database migrations and smoke tests.
-->

# Database Operations

## Domain Migration

The migration script in `db/migrations/01_customer_profile_tables.sql` provisions the normalized MySQL schema for the Customer Profile domain.

To execute the migration locally:

1. Ensure a MySQL 8.0+ instance is running and accessible.
2. Create a database user with privileges to create schemas, tables, and indexes.
3. Run the migration script:
   ```bash
   mysql -u <user> -p <database> < db/migrations/01_customer_profile_tables.sql
   ```
4. Verify the schema objects exist:
   ```sql
   SHOW TABLES;
   ```

## Smoke Tests

After running the migration and test data script:

1. Load seed data with `mysql -u <user> -p <database> < db/scripts/customer_profile_test_data.sql`.
2. Confirm row counts meet expectations:
   ```sql
   SELECT COUNT(*) AS customer_total FROM customer_profile.customer;
   SELECT COUNT(*) AS email_total FROM customer_profile.customer_email;
   SELECT COUNT(*) AS phone_total FROM customer_profile.customer_phone_number;
   ```
3. Inspect the consolidated view for correctness:
   ```sql
   SELECT * FROM customer_profile.v_customer_contact_summary LIMIT 5;
   ```
