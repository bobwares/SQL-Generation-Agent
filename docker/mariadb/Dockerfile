# /**
#  * App: SQL-Generation-Agent
#  * Package: docker.mariadb
#  * File: Dockerfile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Coding Agent
#  * Date: 2025-10-22T19:17:11Z
#  * Exports: MariaDB 11 image with health checks
#  * Description: Provides a MariaDB-compatible runtime for regression testing generated DDL.
#  */
FROM mariadb:11.4

ENV MARIADB_ROOT_PASSWORD=root \
    MARIADB_DATABASE=customer_profile \
    MARIADB_USER=dev \
    MARIADB_PASSWORD=devpass

HEALTHCHECK --interval=10s --timeout=5s --start-period=20s --retries=5 \
    CMD mariadb-admin ping -h localhost -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" || exit 1
