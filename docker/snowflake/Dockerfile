# /**
#  * App: SQL-Generation-Agent
#  * Package: docker.snowflake
#  * File: Dockerfile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Coding Agent
#  * Date: 2025-10-22T19:17:11Z
#  * Exports: Snowflake CLI workstation
#  * Description: Provides the Snowflake CLI and Python SDK for connecting to hosted Snowflake accounts or test harnesses.
#  */
FROM python:3.11-slim

RUN pip install --no-cache-dir snowflake-cli-labs==2.2.1 snowflake-connector-python==3.7.1

WORKDIR /workspace

ENTRYPOINT ["snow"]
CMD ["--help"]
