<!--
App: SQL Generation Agent
Package: db
File: README.md
Version: 0.1.1
Turns: 1
Author: gpt-5-codex
Date: 2025-10-22T20:17:49Z
Exports: Domain migration overview
Description: Documents how to execute the customer profile domain migrations and smoke tests.
-->

# Database Migrations

## Customer Profile Domain

1. Apply the migration scripts in numerical order:
   ```sh
   mysql --host "$MYSQL_HOST" --port "$MYSQL_PORT" --user "$MYSQL_USER" --password="$MYSQL_PASSWORD"      --execute "SOURCE db/migrations/01_customer_profile_tables.sql;"
   ```
2. Load the domain test data:
   ```sh
   mysql --host "$MYSQL_HOST" --port "$MYSQL_PORT" --user "$MYSQL_USER" --password="$MYSQL_PASSWORD"      --execute "SOURCE db/scripts/customer_profile_test_data.sql;"
   ```
3. Validate the row counts using the smoke-test query embedded at the end of the test data script.

> **Note:** Export the environment variables defined in `.env.mysql` or pass them inline when running the commands above.
