<!--
/**
 * App: SQL Generation Agent
 * Package: db
 * File: db/README.md
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T05:33:06Z
 * Exports: Documentation for database migrations and seed scripts
 * Description: Provides instructions for executing customer_profile migrations and verifying generated assets.
 */
-->

# Database Artifacts

## Domain Migration

1. Ensure a MySQL 8.0+ instance is available and accessible.
2. Create the `customer_profile` schema if it does not already exist:
   ```sql
   CREATE DATABASE IF NOT EXISTS customer_profile;
   ```
3. Apply the migration:
   ```bash
   MYSQL_PWD=<PASSWORD> mysql --host <HOST> --user <USER> --database customer_profile < db/migrations/01_customer_profile_tables.sql
   ```
4. Validate that the objects exist:
   ```sql
   SELECT table_name
   FROM information_schema.tables
   WHERE table_schema = 'customer_profile';
   ```

## Smoke Tests

1. Load the deterministic test data:
   ```bash
   MYSQL_PWD=<PASSWORD> mysql --host <HOST> --user <USER> --database customer_profile < db/scripts/customer_profile_test_data.sql
   ```
2. Confirm the dataset populated successfully:
   ```sql
   SELECT COUNT(*) AS customer_count
   FROM customer_profile.customer;
   ```
3. Inspect the reporting view to verify joins:
   ```sql
   SELECT customer_id, email, phone_number
   FROM customer_profile.vw_customer_overview
   ORDER BY customer_id
   LIMIT 10;
   ```
