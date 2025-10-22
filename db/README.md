# Database Artifacts

## Domain Migration

The customer profile domain is provisioned by running the normalized schema and seed scripts against a MySQL 8.0 instance.

### Prerequisites
- MySQL 8.0+ with a user that can create databases and tables.
- A connection configured to operate in UTC.

### Apply the Schema
```bash
mysql -u <user> -p \
  -h <host> \
  -P <port> \
  < /path/to/repo/db/migrations/01_customer_profile_tables.sql
```

### Seed Test Data
```bash
mysql -u <user> -p \
  -h <host> \
  -P <port> \
  < /path/to/repo/db/scripts/customer_profile_test_data.sql
```

### Smoke Test
After running both scripts, connect to the database and execute:
```sql
USE customer_profile;
SELECT COUNT(*) AS customer_count FROM customer;
```
Expect a count of **20** rows.
