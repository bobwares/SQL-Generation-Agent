# Database Migrations

## Customer Profile Domain Migration

1. Ensure a MySQL 8.0+ instance is running and accessible.
2. Create a database user with privileges to create schemas, tables, and views.
3. Execute the migration script:

   ```bash
   mysql -u <user> -p <host_options> < /path/to/db/migrations/01_customer_profile_tables.sql
   ```

4. Seed deterministic test data:

   ```bash
   mysql -u <user> -p <host_options> < /path/to/db/scripts/customer_profile_test_data.sql
   ```

5. Validate the smoke test query output (should report at least 20 customers):

   ```bash
   mysql -u <user> -p -e "USE customer_profile; SELECT COUNT(*) FROM customer;"
   ```

6. (Optional) Inspect the flattened view to confirm joins and aggregations:

   ```bash
   mysql -u <user> -p -e "USE customer_profile; SELECT * FROM customer_profile_overview LIMIT 10;"
   ```

