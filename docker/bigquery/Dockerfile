# /**
#  * App: SQL-Generation-Agent
#  * Package: docker.bigquery
#  * File: Dockerfile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Coding Agent
#  * Date: 2025-10-22T19:17:11Z
#  * Exports: BigQuery emulator container
#  * Description: Wraps the community BigQuery emulator for local contract testing.
#  */
FROM ghcr.io/goccy/bigquery-emulator:latest

EXPOSE 9050

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=5 \
    CMD wget -qO- http://localhost:9050/_ah/health || exit 1
