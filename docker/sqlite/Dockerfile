# /**
#  * App: SQL-Generation-Agent
#  * Package: docker.sqlite
#  * File: Dockerfile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Coding Agent
#  * Date: 2025-10-22T19:17:11Z
#  * Exports: SQLite CLI runtime container
#  * Description: Supplies a minimal shell environment with the SQLite client installed.
#  */
FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends sqlite3 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

VOLUME ["/workspace/db/sqlite"]

WORKDIR /workspace/db/sqlite

ENTRYPOINT ["sqlite3"]
CMD ["/workspace/db/sqlite/customer_profile.db"]
