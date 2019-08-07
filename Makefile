start:
	docker-compose up -d

stop:
	docker-compose stop

setup:
	docker-compose run base setup
	docker-compose rm -f base

client:
	docker-compose run base build
	docker-compose rm -f base

build:
	docker-compose build
