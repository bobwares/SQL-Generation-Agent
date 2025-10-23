# SQL-Generation-Agent

This repository provides a lightweight command-line agent that can transform a JSON Schema domain definition into SQL DDL statements.

## Generating SQL DDL

1. Place your JSON Schema in `schemas/domain.json`. An example schema is already provided based on the customer profile domain.
2. Run the SQL generation agent:
   ```bash
   ./agent run sql-ddl-generator --dialect postgresql --schema-path ./schemas/domain.json --out-dir ./generated/sql
   ```
3. The generated SQL will be written to `generated/sql/<dialect>/<table>.sql`.

The agent currently supports basic JSON Schema constructs (strings, numbers, booleans, objects, and arrays) and will fall back to `JSONB` columns when structure is complex.
