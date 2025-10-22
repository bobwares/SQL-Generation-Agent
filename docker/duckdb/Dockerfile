# /**
#  * App: SQL-Generation-Agent
#  * Package: docker.duckdb
#  * File: Dockerfile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Coding Agent
#  * Date: 2025-10-22T19:17:11Z
#  * Exports: DuckDB CLI container
#  * Description: Provides the DuckDB command-line client for local experimentation.
#  */
FROM python:3.11-slim

RUN pip install --no-cache-dir duckdb==0.10.2

VOLUME ["/workspace/db/duckdb"]

WORKDIR /workspace/db/duckdb

ENTRYPOINT ["duckdb"]
CMD ["/workspace/db/duckdb/customer_profile.duckdb"]
