<!--
/**
 * App: SQL-Generation-Agent
 * Package: documentation
 * File: README.md
 * Version: 0.1.0
 * Turns: 1
 * Author: AI Coding Agent
 * Date: 2025-10-22T19:17:11Z
 * Exports: Project overview
 * Description: Describes project purpose and local development workflows for SQL dialect containers.
 */
-->

# SQL-Generation-Agent

This repository hosts tooling for converting JSON Schema definitions into normalized SQL DDL across multiple SQL dialects. Turn 1 introduces:

- Deterministic MySQL DDL for the `CustomerProfile` schema.
- Seed data scripts for integration testing.
- Containerized environments for every supported SQL dialect.
- A Makefile that automates container lifecycle tasks and data loading for MySQL.

## Quick Start (MySQL)

```bash
make start DIALECT=mysql
make load-schema DIALECT=mysql
make load-data DIALECT=mysql
make query DIALECT=mysql SQL="SELECT COUNT(*) FROM customer;"
```

See [`db/README.md`](db/README.md) for additional validation steps.

## Multi-Dialect Containers

Dockerfiles and Compose services are available for PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, DuckDB, Oracle, Snowflake (CLI), and the BigQuery emulator. Populate the appropriate `.env.<dialect>` file with credentials (sample values are provided in `.env.example`) and use `make start DIALECT=<dialect>` to bring the environment online.

Some services (Snowflake, BigQuery) rely on community tooling or external accounts—review in-container help (`docker compose run snowflake-cli -- --help`) before executing migrations.
