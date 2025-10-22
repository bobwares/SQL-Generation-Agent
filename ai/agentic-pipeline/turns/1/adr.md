# Architecture Decision Record

Select MySQL Dialect for CustomerProfile Migration

**Turn**: 1

**Status**: Accepted

**Date**: 2025-10-22 - 01:09

**Context**
The task specification provided a JSON schema for the CustomerProfile domain and explicitly configured the run for a MySQL environment, while the default task documentation referenced PostgreSQL v16. A single migration and seed data set had to be produced that remains consistent with governance metadata requirements.

**Options Considered**
1. Follow the default task documentation and generate PostgreSQL 16 SQL.
2. Honor the user-supplied configuration and translate the schema to MySQL 8 compatible SQL artifacts.
3. Produce dual-dialect outputs for both PostgreSQL and MySQL.

**Decision**
Option 2 was selected. The user instruction carries higher priority than the template guidance, so the migration and seed scripts target MySQL 8, adapting type choices (e.g., `CHAR(36)` for UUIDs, `ENUM` for phone types, `ON DUPLICATE KEY UPDATE` for idempotent inserts) while still fulfilling normalization, indexing, and metadata header requirements specified by the project pattern.

**Result**
- `db/migrations/01_customer_profile_tables.sql` emits MySQL DDL for normalized tables, constraints, and a flattened view.
- `db/scripts/customer_profile_test_data.sql` seeds 20 consistent domain instances using MySQL idempotent patterns.
- `db/README.md` documents execution steps for the MySQL workflow.

**Consequences**
- The artifacts are ready for MySQL deployments without additional translation.
- If PostgreSQL assets are ever required, a new migration would need to be generated to match that dialect.
