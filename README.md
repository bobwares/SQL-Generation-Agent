<!--
/**
 * App: SQL Generation Agent
 * Package: root
 * File: README.md
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Agent
 * Date: 2025-10-23T05:20:20Z
 * Exports: Documentation
 * Description: Project overview and environment setup instructions.
 */
-->

# SQL Generation Agent

This project converts JSON Schemas into production-ready SQL assets. The initial domain targets the **Customer Profile** schema using PostgreSQL.

## Prerequisites

- Docker 20+
- Docker Compose plugin (`docker compose`)
- GNU Make 4+

## Quick Start

1. Copy environment defaults:
   ```sh
   cp .env.example .env.postgresql
   ```
2. Launch PostgreSQL:
   ```sh
   make docker-up
   ```
3. Apply migrations and load seed data:
   ```sh
   make load-data
   ```
4. Run the smoke-test query:
   ```sh
   make query-count
   ```
5. Tear down services when finished:
   ```sh
   make docker-down
   ```

## Generated Artifacts

- `db/migrations/01_customer_profile_tables.sql` – normalized schema DDL
- `db/scripts/customer_profile_test_data.sql` – idempotent seed data (20 sample customers)
- `docker/postgresql/Dockerfile` & `docker-compose.yml` – containerized development environment
- `.env.postgresql` & `.env.example` – environment configuration templates
- `Makefile` – automation for container lifecycle and database routines

Refer to `db/README.md` for detailed database workflow guidance.
