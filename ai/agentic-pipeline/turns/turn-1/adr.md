# ADR 1 – CustomerProfile MySQL Schema Design

## Status
Accepted – 2025-10-22

## Context
The turn 1 prompt required generating normalized SQL assets for the `CustomerProfile` JSON schema using the MySQL dialect. The governance pattern for agents recommends PostgreSQL defaults, but the user explicitly requested MySQL, necessitating dialect-specific adjustments. The schema includes nested objects and arrays (emails, phone numbers) that must be represented relationally while preserving uniqueness and optional elements.

## Options Considered
| Option | Pros | Cons |
| ------ | ---- | ---- |
| Retain PostgreSQL-oriented defaults (UUID types, CHECK constraints) | Minimal deviation from template tasks | Violates direct user instruction for MySQL, risks incompatible syntax |
| Translate design to MySQL 8.0 with InnoDB tables, ENUM for phone type, `ON DUPLICATE KEY UPDATE` for idempotent seeds | Satisfies dialect requirements, ensures idempotent seed scripts, leverages MySQL-native features | Requires revising examples, adapting index syntax, and ensuring compatibility with MySQL semantics |

## Decision
Chosen: Translate the CustomerProfile design to MySQL 8.0 using InnoDB storage, CHAR(36) identifiers for UUIDs, ENUM types for phone classifications, and idempotent seed scripts built on `ON DUPLICATE KEY UPDATE`. This honors the user-specified dialect while maintaining normalized structure and governance expectations (metadata headers, directory layout).

## Consequences
- Migration and seed scripts run cleanly on MySQL 8.0+ and remain idempotent for repeated execution.
- Additional maintenance is needed if PostgreSQL-specific behaviors were assumed elsewhere in the pipeline.
- Using CHAR(36) may incur slightly larger storage compared to binary UUIDs but keeps the scripts self-contained without helper functions.

## Follow-ups / Tickets
- Evaluate whether future turns should include automated MySQL linting or formatting to enforce dialect rules.
