# Architecture Decision Record – Turn 1

## Context
The CustomerProfile JSON schema required a MySQL implementation that preserves nested structures (address, privacy settings, emails, phone numbers) while remaining in at least third normal form. The project also needed deterministic seed data and a reproducible container workflow for local development.

## Options Considered
| Option | Pros | Cons |
| --- | --- | --- |
| Embed nested objects directly in a single `customer` table | Fewer joins, simplified scripts | Violates normalization, complicates arrays (emails/phones) |
| Normalize into dedicated tables with strict constraints and helper view | Preserves data integrity, scales to arrays, supports analytics | Requires additional joins and setup |
| Delay container automation | Lower upfront work | Inconsistent local environments, harder onboarding |

## Decision
Chose full normalization with separate tables for `postal_address`, `privacy_settings`, `customer_email`, and `customer_phone_number`, complemented by a `customer_profile_overview` view for quick access. Adopted `INSERT ... ON DUPLICATE KEY UPDATE` for idempotent seed scripts and delivered Docker Compose assets plus a Makefile to standardize workflows.

## Result
- Added DDL in `db/migrations/01_customer_profile_tables.sql` with constraints, indexes, and view.
- Seeded deterministic data in `db/scripts/customer_profile_test_data.sql`.
- Provisioned `docker-compose.yml`, `docker/mysql/Dockerfile`, and environment files for a local MySQL service.
- Documented usage in `README.md`, `db/README.md`, and Makefile targets.

## Consequences
- Additional tables increase schema complexity but ensure third normal form and reusability of shared records (privacy settings, addresses).
- Developers can bootstrap MySQL quickly via Docker Compose, but must maintain environment variables securely.
- Seed strategy assumes fixed primary keys; future migrations must preserve those identifiers or refresh references accordingly.

## Metrics
- Files changed: pending manifest metrics.
- Tests run: none (manual verification only).

## Validation
- ADR present: yes.
- Changelog present: yes.
- Linting/tests: not executed in this turn.

## Evidence
- See `ai/agentic-pipeline/turns/turn-1/changelog.md` for task log and artifact listing.
