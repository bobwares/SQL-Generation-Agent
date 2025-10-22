<!--
App: SQL Generation Agent
Package: root
File: README.md
Version: 0.1.0
Turns: 1
Author: gpt-5-codex
Date: 2025-10-22T20:17:49Z
Exports: Project overview, Docker workflow
Description: Documents the SQL DDL generation workflow and local MySQL environment setup.
-->

# SQL Generation Agent

This repository contains automation assets for generating MySQL DDL and seed data from JSON Schema definitions.

## Getting Started

1. Copy `.env.example` to `.env.mysql` (or update the existing file) and adjust credentials as needed.
2. Build and start the MySQL profile:
   ```sh
   docker compose --profile mysql up --build -d
   ```
3. Apply the generated schema and seed data:
   ```sh
   mysql --host "$MYSQL_HOST" --port "$MYSQL_PORT" --user "$MYSQL_USER" --password="$MYSQL_PASSWORD" \
     --execute "SOURCE db/migrations/01_customer_profile_tables.sql;"
   mysql --host "$MYSQL_HOST" --port "$MYSQL_PORT" --user "$MYSQL_USER" --password="$MYSQL_PASSWORD" \
     --execute "SOURCE db/scripts/customer_profile_test_data.sql;"
   ```
4. Verify the smoke-test query reported in the seed script returns at least 20 customers.

## Stopping the Environment

```sh
docker compose --profile mysql down
```

## Additional Notes

- Custom initialization SQL can be added under `docker/mysql/init` to run automatically when the container starts.
- Migration and script files are idempotent, enabling repeatable local runs.
