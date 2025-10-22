<!--
/**
 * App: SQL-Generation-Agent
 * Package: db
 * File: README.md
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T01:09:09Z
 * Exports: Documentation
 * Description: Describes how to apply the CustomerProfile MySQL migration and load sample data.
 */
-->

# Customer Profile Database Artifacts

This directory contains the generated MySQL migration and seed data for the **CustomerProfile** domain.

## Structure

- `migrations/01_customer_profile_tables.sql` – Creates the `customer_profile` schema, normalized tables, constraints, indexes, and a reporting view.
- `scripts/customer_profile_test_data.sql` – Loads 20 deterministic customer records plus supporting addresses, privacy settings, emails, and phone numbers.

## Prerequisites

- MySQL 8.0 or newer.
- A user with privileges to create schemas, tables, and views.

## Applying the Migration

```bash
mysql --host <host> --port <port> --user <user> --password
SOURCE db/migrations/01_customer_profile_tables.sql;
```

The script opens a transaction, creates the `customer_profile` schema if needed, and is idempotent thanks to `IF NOT EXISTS` guards.

## Loading Test Data

```bash
mysql --host <host> --port <port> --user <user> --password
SOURCE db/scripts/customer_profile_test_data.sql;
```

The seed script runs in UTC, uses `ON DUPLICATE KEY UPDATE` to remain idempotent, and finishes with a smoke test query returning the customer count.

## Smoke Testing

After running both scripts, verify the output:

```sql
SELECT * FROM customer_profile.customer_profile_view LIMIT 5;
```

This view flattens the customer profile into a single row per customer with aggregated contact information for quick inspection.
