# /**
#  * App: SQL-Generation-Agent
#  * Package: docker.mssql
#  * File: Dockerfile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Coding Agent
#  * Date: 2025-10-22T19:17:11Z
#  * Exports: SQL Server 2022 image configuration
#  * Description: Enables SQL Server local testing with default credentials.
#  */
FROM mcr.microsoft.com/mssql/server:2022-latest

ENV ACCEPT_EULA=Y \
    MSSQL_SA_PASSWORD=LocalStrongPassw0rd! \
    MSSQL_PID=Developer

HEALTHCHECK --interval=15s --timeout=5s --start-period=40s --retries=5 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -Q "SELECT 1" || exit 1
