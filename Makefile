.PHONY: all build up down restart logs clean

all: up

build:
	docker compose -f docker-compose.yml build

up:
	docker compose -f docker-compose.yml up -d

down:
	docker compose -f docker-compose.yml down

restart: down up

logs:
	docker compose -f docker-compose.yml logs -f

clean:
	docker compose -f docker-compose.yml down -v --remove-orphans
	docker volume rm $$(docker volume ls -qf "label=com.docker.compose.project=$(basename $(PWD))") 2>/dev/null || true
	docker network rm $$(docker network ls -qf "label=com.docker.compose.project=$(basename $(PWD))") 2>/dev/null || true
	docker system prune -a -f --volumes
	sudo rm -rf ../../../jmouline/data/mariadb/* ../../../jmouline/data/nginx/* ../../../jmouline/data/wordpress/*

ps:
	docker compose -f docker-compose.yml ps

exec-wp:
	docker exec -it wordpress /bin/bash

exec-nginx:
	docker exec -it nginx /bin/bash

exec-mariadb:
	docker exec -it mariadb /bin/bash
