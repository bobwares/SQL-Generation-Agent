<!--
/**
 * App: SQL-Generation-Agent
 * Package: db
 * File: README.md
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T19:17:11Z
 * Exports: Migration workflow documentation
 * Description: Explains how to run the customer profile migrations, seed data, and verification checks.
 */
-->

# Customer Profile Database Assets

## Overview

The customer profile domain is derived from the provided JSON schema and consists of:

- `postal_address`
- `privacy_settings`
- `customer`
- `customer_email`
- `customer_phone_number`
- `customer_profile_overview` view aggregating the normalized tables

The canonical migration lives at `db/migrations/01_customer_profile_tables.sql` and the deterministic test data set is located at `db/scripts/customer_profile_test_data.sql`.

## Prerequisites

- Docker and Docker Compose v2
- GNU Make 3.81+
- MySQL client tools (optional when using the provided containers)

## Applying the Migration

1. Start the database container:
   ```bash
   make start DIALECT=mysql
   ```
2. Load the schema:
   ```bash
   make load-schema DIALECT=mysql
   ```
3. Load the seed data:
   ```bash
   make load-data DIALECT=mysql
   ```
4. Run the smoke test query:
   ```bash
   make query DIALECT=mysql SQL="SELECT COUNT(*) AS customer_count FROM customer;"
   ```

Each Makefile target automatically sources the matching `.env.<dialect>` file for connection details. Default credentials are safe for local development only.

## Validation Checklist

- Run `SELECT * FROM customer_profile_overview LIMIT 5;` to confirm the flattened view returns rows.
- Ensure `customer_email` and `customer_phone_number` tables enforce uniqueness via their composite keys.
- Rerun the seed script to confirm idempotency (row counts remain 20 without duplication).

## Additional Dialects

Dockerfiles and Compose services exist for every supported dialect listed in the project context. Non-MySQL engines may require manual schema translation prior to execution. Refer to the root `README.md` for engine-specific notes and connection details.
