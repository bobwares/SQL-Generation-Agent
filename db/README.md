# Database Assets

## Domain Migration

1. Ensure a MySQL 8.0 instance is available and accessible.
2. Execute the normalized schema from the repository root:
   ```bash
   mysql --host=<host> --user=<user> --password < db/migrations/01_customer_profile_tables.sql
   ```
3. Seed deterministic test data:
   ```bash
   mysql --host=<host> --user=<user> --password < db/scripts/customer_profile_test_data.sql
   ```
4. Verify the smoke-test query output reports at least 20 customer rows:
   ```bash
   mysql --host=<host> --user=<user> --password --database=customer_profile --execute "SELECT COUNT(*) AS customer_count FROM customer;"
   ```

## Notes

- The migration script is idempotent and uses `CREATE TABLE IF NOT EXISTS` semantics for repeatable runs.
- Seed data relies on `ON DUPLICATE KEY UPDATE` to remain idempotent across multiple executions.
- Scripts assume the `customer_profile` schema; adjust the `USE` directive if a different schema is required.
