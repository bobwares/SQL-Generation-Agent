# /**
#  * App: SQL Generation Agent
#  * Package: build
#  * File: Makefile
#  * Version: 0.1.0
#  * Turns: 1
#  * Author: AI Agent
#  * Date: 2025-10-23T05:20:20Z
#  * Exports: docker-up, docker-down, apply-migrations, seed-data, load-data, query-count, psql
#  * Description: Automates database container lifecycle, migration application, and smoke testing.
#  */
COMPOSE ?= docker compose
ENV_FILE ?= .env.postgresql
ifneq (,$(wildcard $(ENV_FILE)))
include $(ENV_FILE)
export $(shell sed -n 's/^\([A-Za-z0-9_]\+\)=.*/\1/p' $(ENV_FILE))
endif
PSQL_CMD = $(COMPOSE) --profile postgresql exec -T postgresql-db psql -v ON_ERROR_STOP=1 -U $(POSTGRES_USER) -d $(POSTGRES_DB)
.PHONY: docker-up docker-down apply-migrations seed-data load-data query-count psql
docker-up:
	$(COMPOSE) --profile postgresql up -d postgresql-db
docker-down:
	$(COMPOSE) --profile postgresql down --remove-orphans
apply-migrations:
	$(PSQL_CMD) -f /docker-entrypoint-initdb.d/migrations/01_customer_profile_tables.sql
seed-data:
	$(PSQL_CMD) -f /docker-entrypoint-initdb.d/scripts/customer_profile_test_data.sql
load-data: apply-migrations seed-data
query-count:
	$(PSQL_CMD) -c "SELECT COUNT(*) AS customer_count FROM customer_profile.customer;"
psql:
	$(PSQL_CMD)
