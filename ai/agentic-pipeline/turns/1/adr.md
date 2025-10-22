<!--
 * App: SQL Generation Agent
 * Package: ai/agentic-pipeline/turns
 * File: adr.md
 * Version: 0.1.0
 * Turns: 1
 * Author: codex-agent
 * Date: 2025-10-20T00:21:21Z
 * Exports: architecture decision record
 * Description: Documents the design choices made while generating PostgreSQL DDL for turn 1.
 -->
# Architecture Decision Record

CustomerProfile PostgreSQL Relational Mapping

**Turn**: 1

**Status**: Accepted

**Date**: 2025-10-20 - 00:21

**Context**
The CustomerProfile JSON Schema includes nested objects (postal address, privacy settings) and collections (emails, phone numbers) with validation requirements such as minLength, uniqueness, and format constraints. PostgreSQL must persist this data with normalized structures and enforce required constraints.

**Options Considered**
1. Store array fields (emails, phoneNumbers) directly in JSONB or ARRAY columns with CHECK constraints.
2. Normalize array fields into separate tables with relational constraints and triggers to enforce cardinality requirements.

**Decision**
Selected option 2. Separate tables provide better queryability, allow referential integrity, and enable fine-grained constraints (e.g., regex validation, unique primary keys). Added triggers to enforce the "at least one email" rule and used ENUM types for the bounded phone number type list, aligning with PostgreSQL best practices for controlled vocabularies.

**Result**
- Created `phone_number_type` enum.
- Added `customer_profiles`, `customer_addresses`, `customer_emails`, and `customer_phone_numbers` tables with comments and constraints.
- Implemented triggers to maintain `updated_at` timestamps and guarantee each profile retains at least one email row.

**Consequences**
- Slightly increased schema complexity due to additional tables and trigger logic.
- Ensures data integrity for required arrays and improves long-term maintainability and query performance.
- Requires client code to operate within transactions when creating profiles and related emails so deferred constraint checks succeed.
