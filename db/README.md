<!--
/**
 * App: SQL Generation Agent
 * Package: db
 * File: README.md
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Agent
 * Date: 2025-10-23T05:20:20Z
 * Exports: Documentation
 * Description: Database migration and data loading instructions for the Customer Profile domain.
 */
-->

# Database Operations

## Customer Profile Migration

1. Ensure Docker services are running for PostgreSQL (see project root `README.md`).
2. Connect to the database using the credentials defined in `.env.postgresql`.
3. Apply the migration:
   ```sh
   psql "$${POSTGRESQL_URL}" -f db/migrations/01_customer_profile_tables.sql
   ```
4. Verify that the `customer_profile` schema contains the expected tables and view:
   ```sql
   \dn+ customer_profile
   \dt customer_profile.*
   \dv customer_profile.*
   ```

## Test Data Seed

1. Run the migration prior to loading data.
2. Execute the idempotent seed script:
   ```sh
   psql "$${POSTGRESQL_URL}" -f db/scripts/customer_profile_test_data.sql
   ```
3. Confirm smoke-test query results are ≥ 10 rows to validate inserts.

## Smoke Testing Workflow

1. Run `make docker-up` to start PostgreSQL locally.
2. Run `make load-data` to apply migrations and load seed data.
3. Execute `make query-count` to run the smoke-test counting query.

All scripts are idempotent, allowing safe re-execution during development.
