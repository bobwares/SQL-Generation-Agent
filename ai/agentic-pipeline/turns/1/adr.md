# Architecture Decision Record

MySQL-Oriented Customer Profile Schema

**Turn**: 1

**Status**: Accepted

**Date**: 2025-10-22 - 01:42

**Context**
The project must translate the provided CustomerProfile JSON schema into relational artifacts while honoring the user-specified configuration that targets MySQL. Existing task templates reference PostgreSQL conventions, creating a conflict that requires an explicit dialect selection.

**Options Considered**
1. Follow the task template verbatim and emit PostgreSQL DDL regardless of user configuration.
2. Generate vendor-neutral SQL that avoids dialect-specific capabilities.
3. Honor the MySQL configuration by emitting MySQL-native DDL and seed data features.

**Decision**
Chose option 3 and produced fully MySQL-compatible artifacts. This includes using `CHAR(36)` UUID columns with `DEFAULT (UUID())`, `ENUM` types for phone number categories, `ON DUPLICATE KEY UPDATE` for idempotent seeds, and explicit `ENGINE=InnoDB` declarations. The metadata header and directory structure remain consistent with project governance.

**Result**
- `db/migrations/01_customer_profile_tables.sql`
- `db/scripts/customer_profile_test_data.sql`
- `db/README.md`

**Consequences**
- The migration and seed scripts run without modification on MySQL 8.0+.
- Future turns must continue to align with MySQL features or update the configuration explicitly.
- PostgreSQL-specific acceptance text in task files remains outdated relative to generated assets.
