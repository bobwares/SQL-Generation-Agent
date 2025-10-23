# ADR 1: Customer Profile PostgreSQL Implementation Baseline

## Context
The CustomerProfile JSON schema must be materialized into a PostgreSQL-compliant relational design while providing deterministic local execution and test data workflows.

## Options Considered
| Option | Pros | Cons |
|--------|------|------|
| Normalize schema with dedicated reference tables and enums | Aligns with 3NF, enforces referential integrity, supports query performance | Requires multiple tables and foreign keys |
| Store nested structures as JSON columns | Simplifies schema mapping, fewer tables | Violates normalization requirements, harder to query, limited constraint enforcement |
| Hybrid approach (partial JSON, partial normalized) | Balances flexibility and structure | Inconsistent modeling, complicates tooling |

## Decision
**Chosen**: Normalize schema with dedicated reference tables and enums. <br/>
**Justification**: Satisfies 3NF mandate, enables idempotent migrations, and allows rich constraint enforcement (CHECK, FK, ENUM) aligned with project governance.

## Result
Artifacts created: `db/migrations/01_customer_profile_tables.sql`, `db/scripts/customer_profile_test_data.sql`, `docker/postgresql/Dockerfile`, `docker-compose.yml`, `.env.postgresql`, `.env.example`, `Makefile`, `db/README.md`.

## Consequences
- Reliable relational model ready for further evolution.
- Additional scripts (Docker/Makefile) ensure onboarding consistency.
- Future schema changes must preserve metadata headers and update automation recipes.
