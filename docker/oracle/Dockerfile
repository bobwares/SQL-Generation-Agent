# /**
#  * App: SQL-Generation-Agent
#  * Package: docker.oracle
#  * File: Dockerfile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Coding Agent
#  * Date: 2025-10-22T19:17:11Z
#  * Exports: Oracle Database Free image configuration
#  * Description: Supplies an Oracle XE-compatible container for schema validation.
#  */
FROM gvenzl/oracle-free:23-slim

ENV ORACLE_PWD=Local0raclePwd!

HEALTHCHECK --interval=30s --timeout=5s --start-period=120s --retries=10 \
    CMD /opt/oracle/checkDBStatus.sh || exit 1
