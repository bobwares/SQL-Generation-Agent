# ADR: CustomerProfile MySQL Normalization (Turn 1)
- Date: 2025-10-22T08:39:28Z
- Status: Accepted

## Context
The CustomerProfile JSON Schema must be transformed into normalized MySQL DDL for turn 1.
The schema requires capturing customer identity, postal addresses, privacy preferences,
and collections of emails and phone numbers while preserving uniqueness constraints.

## Options Considered
1. **Embed nested data as JSON columns** – simplify storage but sacrifice relational
   integrity, indexing, and normalized structure required by the task.
2. **Fully normalized tables with surrogate keys** – model each nested object/collection
   as its own table with foreign keys, indexes, and guard rails.

## Decision
Adopt the fully normalized relational design using surrogate keys where the schema does not
supply identifiers. This approach aligns with the task requirement to reach third normal form,
ensures predictable foreign-key constraints, and keeps array members unique per customer.

## Consequences
- Introduced separate `postal_address`, `privacy_settings`, `customer_email`, and
  `customer_phone_number` tables linked to the `customer` root table.
- Added explicit indexes for lookup-heavy columns and a `customer_overview` view to support
  reporting queries without denormalizing tables.
- Seed data script must respect the surrogate keys and maintain idempotency with
  `ON DUPLICATE KEY UPDATE` semantics in MySQL.
