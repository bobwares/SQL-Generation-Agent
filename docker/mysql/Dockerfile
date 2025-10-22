# App: SQL Generation Agent
# Package: docker.mysql
# File: Dockerfile
# Version: 0.1.1
# Turns: 1
# Author: gpt-5-codex
# Date: 2025-10-22T20:17:49Z
# Exports: MySQL container image definition
# Description: Builds a MySQL 8.0 image configured for the CustomerProfile domain development environment.

FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD="rootpassword" \
    MYSQL_DATABASE="customer_profile" \
    MYSQL_USER="customer_app" \
    MYSQL_PASSWORD="customer_app_password"

COPY init/ /docker-entrypoint-initdb.d/

HEALTHCHECK --interval=10s --timeout=5s --retries=10 CMD mysqladmin ping -h localhost -prootpassword || exit 1
