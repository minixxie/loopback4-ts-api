SHELL := /bin/bash
DOCKER := 1

.PHONY: docker-shell
docker-shell:
	@echo "You may type 'npm i -g @loopback/cli' to install the loopback4 cli (https://loopback.io/doc/en/lb4/Getting-started.html):"
	docker run --rm -it -v "$$PWD:/home/node/app" -w /home/node/app node:18.12-alpine3.16 sh

.PHONY: up
up: down
	@if [ "${DOCKER}" == 1 ]; then \
		DOCKER_BUILDKIT=1 docker-compose up -d; \
	else \
		yarn start; \
	fi

.PHONY: down
down:
	@if [ "${DOCKER}" == 1 ]; then \
		docker rm -f loopback4_ts_api || true; \
	else \
		echo "Not implemented yet."; \
	fi

.PHONY: logs
logs:
	@if [ "${DOCKER}" == 1 ]; then \
		docker logs -f loopback4_ts_api; \
	else \
		echo "Not implemented yet."; \
	fi

.PHONY: ping
ping:
	curl -v http://$$(minikube ip)/ping -H 'Host: loopback4-ts-api.local'
