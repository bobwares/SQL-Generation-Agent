# /**
#  * App: SQL Generation Agent
#  * Package: docker.postgresql
#  * File: Dockerfile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Agent
#  * Date: 2025-10-23T05:20:20Z
#  * Exports: PostgreSQL container image definition
#  * Description: Builds a PostgreSQL image tailored for local Customer Profile development.
#  */

FROM postgres:16-alpine

LABEL maintainer="AI Agent" \
      org.opencontainers.image.title="SQL Generation Agent - PostgreSQL" \
      org.opencontainers.image.description="PostgreSQL instance for Customer Profile development" \
      org.opencontainers.image.version="0.1.0"

ENV POSTGRES_USER=postgres \
    POSTGRES_PASSWORD=postgres \
    POSTGRES_DB=customer_profile

RUN apk add --no-cache bash postgresql-contrib

COPY db/migrations /docker-entrypoint-initdb.d/migrations
COPY db/scripts /docker-entrypoint-initdb.d/scripts

HEALTHCHECK --interval=10s --timeout=5s --retries=5 CMD pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"
