.PHONY: build up test

build:
	docker build -t bhealthdemo:local -f bhealthdemo/Dockerfile .

up:
	docker compose -f bhealthdemo/docker-compose.yml up --build

test:
	docker run --rm bhealthdemo:local npm test
