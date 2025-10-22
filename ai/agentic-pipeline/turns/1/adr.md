# Architecture Decision Record

Customer Profile Schema on MySQL 8

**Turn**: 1

**Status**: Accepted

**Date**: 2025-10-21 - 23:58 UTC

**Context**
The project must generate normalized relational structures and test data from the provided CustomerProfile JSON schema. The user configured the environment to use MySQL, while the default task template referenced PostgreSQL behaviors.

**Options Considered**
1. Follow the template literally and emit PostgreSQL-specific SQL.
2. Translate the schema into vendor-neutral SQL lacking dialect guarantees.
3. Honor the user-provided MySQL configuration and tailor the DDL and seeds for MySQL 8.0+ features.

**Decision**
Adopt option 3. Generate MySQL 8 compatible DDL and seed scripts, including use of `ENUM`, `ON DUPLICATE KEY UPDATE`, and schema selection via `USE customer_profile`. This honors the turn input while preserving normalization, constraints, and governance metadata requirements.

**Result**
- Created `db/migrations/01_customer_profile_tables.sql` with MySQL-compliant DDL.
- Authored `db/scripts/customer_profile_test_data.sql` using idempotent inserts suited for MySQL.
- Documented execution steps in `db/README.md`.

**Consequences**
+ Aligns generated artifacts with the requested database platform.
+ Maintains referential integrity, indexes, and flattened reporting view needed for analytics.
- Future turns targeting PostgreSQL would require dialect adjustments or alternate scripts.
