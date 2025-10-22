# /**
#  * App: SQL-Generation-Agent
#  * Package: docker.mysql
#  * File: Dockerfile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Coding Agent
#  * Date: 2025-10-22T19:17:11Z
#  * Exports: MySQL 8 image with initialization hooks
#  * Description: Configures a MySQL instance for executing generated DDL and seed scripts.
#  */
FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=root \
    MYSQL_DATABASE=customer_profile \
    MYSQL_USER=dev \
    MYSQL_PASSWORD=devpass

RUN mkdir -p /docker-entrypoint-initdb.d

HEALTHCHECK --interval=10s --timeout=5s --start-period=20s --retries=5 \
    CMD mysqladmin ping -h localhost -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" || exit 1
