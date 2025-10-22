# App: SQL Generation Agent
# Package: build
# File: Makefile
# Version: 0.1.3
# Turns: 1
# Author: gpt-5-codex
# Date: 2025-10-22T20:17:49Z
# Exports: start-mysql, stop-mysql, load-migrations, load-test-data, query-customers
# Description: Provides convenience commands for managing the MySQL development environment.

SHELL := /bin/bash

start-mysql:
	docker compose --profile mysql up --build -d

stop-mysql:
	docker compose --profile mysql down

load-migrations:
	MYSQL_HOST=$$(grep '^MYSQL_HOST' .env.mysql | cut -d'=' -f2); 	MYSQL_PORT=$$(grep '^MYSQL_PORT' .env.mysql | cut -d'=' -f2); 	MYSQL_USER=$$(grep '^MYSQL_USER' .env.mysql | cut -d'=' -f2); 	MYSQL_PASSWORD=$$(grep '^MYSQL_PASSWORD' .env.mysql | cut -d'=' -f2); 	mysql --host $$MYSQL_HOST --port $$MYSQL_PORT --user $$MYSQL_USER --password=$$MYSQL_PASSWORD \
	  --execute "SOURCE db/migrations/01_customer_profile_tables.sql;"

load-test-data:
	MYSQL_HOST=$$(grep '^MYSQL_HOST' .env.mysql | cut -d'=' -f2); 	MYSQL_PORT=$$(grep '^MYSQL_PORT' .env.mysql | cut -d'=' -f2); 	MYSQL_USER=$$(grep '^MYSQL_USER' .env.mysql | cut -d'=' -f2); 	MYSQL_PASSWORD=$$(grep '^MYSQL_PASSWORD' .env.mysql | cut -d'=' -f2); 	mysql --host $$MYSQL_HOST --port $$MYSQL_PORT --user $$MYSQL_USER --password=$$MYSQL_PASSWORD \
	  --execute "SOURCE db/scripts/customer_profile_test_data.sql;"

query-customers:
	MYSQL_HOST=$$(grep '^MYSQL_HOST' .env.mysql | cut -d'=' -f2); 	MYSQL_PORT=$$(grep '^MYSQL_PORT' .env.mysql | cut -d'=' -f2); 	MYSQL_USER=$$(grep '^MYSQL_USER' .env.mysql | cut -d'=' -f2); 	MYSQL_PASSWORD=$$(grep '^MYSQL_PASSWORD' .env.mysql | cut -d'=' -f2); 	MYSQL_DATABASE=$$(grep '^MYSQL_DATABASE' .env.mysql | cut -d'=' -f2); 	mysql --host $$MYSQL_HOST --port $$MYSQL_PORT --user $$MYSQL_USER --password=$$MYSQL_PASSWORD \
	  --database $$MYSQL_DATABASE --execute "SELECT * FROM customer_profile_overview ORDER BY last_name;"

.PHONY: start-mysql stop-mysql load-migrations load-test-data query-customers
