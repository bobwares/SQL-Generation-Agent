# /**
#  * App: SQL-Generation-Agent
#  * Package: build
#  * File: Makefile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Coding Agent
#  * Date: 2025-10-22T19:17:11Z
#  * Exports: start, stop, load-schema, load-data, query targets
#  * Description: Simplifies orchestration of dialect containers and data management tasks.
#  */

DIALECT ?= mysql
COMPOSE ?= docker compose
ENV_FILE := .env.$(DIALECT)
SERVICE_postgresql := postgresql-db
SERVICE_mysql := mysql-db
SERVICE_mariadb := mariadb-db
SERVICE_mssql := mssql-db
SERVICE_sqlite := sqlite-db
SERVICE_duckdb := duckdb-db
SERVICE_oracle := oracle-db
SERVICE_snowflake := snowflake-cli
SERVICE_bigquery := bigquery-emulator
SERVICE := $(SERVICE_$(DIALECT))

SCHEMA_SCRIPT := db/migrations/01_customer_profile_tables.sql
DATA_SCRIPT := db/scripts/customer_profile_test_data.sql

.PHONY: help start stop logs load-schema load-data query status

help:
@echo "Available targets:"
@echo "  make start DIALECT=<dialect>      # Start the selected database container"
@echo "  make stop DIALECT=<dialect>       # Stop the selected database container"
@echo "  make load-schema DIALECT=mysql    # Apply the customer profile schema"
@echo "  make load-data DIALECT=mysql      # Seed deterministic customer profile data"
@echo "  make query DIALECT=mysql SQL=...  # Execute an ad-hoc query against the schema"
@echo "  make logs DIALECT=<dialect>       # Tail container logs"
@echo "  make status DIALECT=<dialect>     # Show docker-compose service status"

start:
@if [ -z "$(SERVICE)" ]; then echo "Unsupported dialect: $(DIALECT)"; exit 1; fi
@if [ ! -f "$(ENV_FILE)" ]; then echo "Missing env file: $(ENV_FILE)"; exit 1; fi
@bash -c 'set -a; source $(ENV_FILE); $(COMPOSE) --profile $(DIALECT) up -d $(SERVICE)'

stop:
@if [ -z "$(SERVICE)" ]; then echo "Unsupported dialect: $(DIALECT)"; exit 1; fi
@if [ ! -f "$(ENV_FILE)" ]; then echo "Missing env file: $(ENV_FILE)"; exit 1; fi
@bash -c 'set -a; source $(ENV_FILE); $(COMPOSE) --profile $(DIALECT) down --remove-orphans'

logs:
@if [ -z "$(SERVICE)" ]; then echo "Unsupported dialect: $(DIALECT)"; exit 1; fi
@$(COMPOSE) logs -f $(SERVICE)

status:
@$(COMPOSE) ps

load-schema:
@if [ "$(DIALECT)" != "mysql" ]; then echo "Schema loading is currently automated for DIALECT=mysql only."; exit 1; fi
@if [ ! -f "$(SCHEMA_SCRIPT)" ]; then echo "Missing schema script: $(SCHEMA_SCRIPT)"; exit 1; fi
@if [ ! -f "$(ENV_FILE)" ]; then echo "Missing env file: $(ENV_FILE)"; exit 1; fi
@bash -c 'set -a; source $(ENV_FILE); cat $(SCHEMA_SCRIPT) | $(COMPOSE) exec -T $(SERVICE) mysql -u"$$MYSQL_USER" -p"$$MYSQL_PASSWORD"'

load-data:
@if [ "$(DIALECT)" != "mysql" ]; then echo "Data loading is currently automated for DIALECT=mysql only."; exit 1; fi
@if [ ! -f "$(DATA_SCRIPT)" ]; then echo "Missing data script: $(DATA_SCRIPT)"; exit 1; fi
@if [ ! -f "$(ENV_FILE)" ]; then echo "Missing env file: $(ENV_FILE)"; exit 1; fi
@bash -c 'set -a; source $(ENV_FILE); cat $(DATA_SCRIPT) | $(COMPOSE) exec -T $(SERVICE) mysql -u"$$MYSQL_USER" -p"$$MYSQL_PASSWORD"'

query:
@if [ "$(DIALECT)" != "mysql" ]; then echo "Ad-hoc query execution is currently automated for DIALECT=mysql only."; exit 1; fi
@if [ -z "$(SQL)" ]; then echo "Provide SQL=<statement> to run."; exit 1; fi
@if [ ! -f "$(ENV_FILE)" ]; then echo "Missing env file: $(ENV_FILE)"; exit 1; fi
@bash -c 'set -a; source $(ENV_FILE); $(COMPOSE) exec -T $(SERVICE) mysql -u"$$MYSQL_USER" -p"$$MYSQL_PASSWORD" -D "$$MYSQL_DATABASE" -e "$(SQL)"'
