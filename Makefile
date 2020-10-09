.PHONY: help
help:
	#
	# COMMON COMMANDS :
	#
	# make pull => git pull of current branch
	# make clear-cache => clear cache and apply rights on cache folder
	# make install => execute clear cache and composer install
	#
	# LOCAL COMMANDS :
	#
	# make up => run all containers
	# make down => stop all containers
	# make php => access php container
	# make composer-update => execute composer update
	#
	# PROD COMMANDS :
	# make deploy => update source, vendors, clear-cache, assets generation and (re)start containers
	#

.PHONY: up
up:
	docker-compose -f docker-compose.local.yml up -d

.PHONY: down
down:
	docker-compose -f docker-compose.local.yml down

.PHONY: pull
pull:
	git pull origin $(git rev-parse --abbrev-ref HEAD)

.PHONY: php
php:
	docker-compose exec php sh

.PHONY: composer-update
composer-update:
	docker-compose exec php php -d memory_limit=-1 /usr/local/bin/composer update

.PHONY: install
install:
	${MAKE} clear-cache
	docker-compose exec php composer install
	docker-compose exec php bin/console doctrine:migration:migrate -n

.PHONY: clear-cache
clear-cache:
	rm -rf var/cache/*
	docker-compose exec php bin/console c:cl
	docker-compose exec php chmod 777 var/cache -R

.PHONY: deploy
deploy:
	${MAKE} pull
	${MAKE} install
	docker-compose exec php yarn encore production
	docker-compose stop
	docker-compose up -d

