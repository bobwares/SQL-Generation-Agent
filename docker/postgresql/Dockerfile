# /**
#  * App: SQL-Generation-Agent
#  * Package: docker.postgresql
#  * File: Dockerfile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Coding Agent
#  * Date: 2025-10-22T19:17:11Z
#  * Exports: PostgreSQL 16 image with health checks
#  * Description: Provides a PostgreSQL service for validating generated DDL scripts.
#  */
FROM postgres:16-alpine

ENV POSTGRES_USER=postgres \
    POSTGRES_PASSWORD=postgres \
    POSTGRES_DB=customer_profile

HEALTHCHECK --interval=10s --timeout=5s --start-period=15s --retries=5 \
    CMD pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" || exit 1
