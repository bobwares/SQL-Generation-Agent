# Database Migrations

## Domain Migration

This repository contains PostgreSQL 16 migrations generated from the project JSON schemas.

To apply the customer profile migration locally:

1. Export database connection details via `DATABASE_URL` (e.g., `postgresql://localhost:5432/postgres`).
2. Run the migration with your preferred tool, for example:
   ```bash
   psql "$DATABASE_URL" -f db/migrations/01_customer_profile_tables.sql
   ```
3. Verify the objects:
   - Inspect tables with `\dt customer_profile.*`.
   - Review the flattened view using `SELECT * FROM customer_profile.customer_profile_overview LIMIT 5;`.
4. Roll back by dropping the schema if needed:
   ```sql
   DROP SCHEMA IF EXISTS customer_profile CASCADE;
   ```

For smoke testing, insert a customer, associated emails, and phone numbers, then query the `customer_profile_overview` view to confirm aggregation behavior.
