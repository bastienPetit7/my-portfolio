##################
# Variables
##################
DOCKER_COMPOSE = docker compose
DOCKER_EXEC = docker exec -ti
PROJECT_ID = vcy25cnjap45y
DOCKER_NODE = docker compose -f ./docker-compose.yml run --rm -u root node

_END=\x1b[0m
_GREY=\x1b[30m
_GREEN=\x1b[32m
_YELLOW=\x1b[33m

.PHONY: help
		blackfire-curl
		import_platform_db

help:
	@echo "${_YELLOW}Usage:${_END}"
	@echo "${_WHITE}     make [command]${_END}"
	@echo ""
	@echo "${_YELLOW}Available commands:${_END}"
	@grep  '^[^#[:space:]].*:' $(MAKEFILE_LIST) /dev/null | \
		grep -vE ':(default|help|all|doc)' | \
		grep -v ':\.[^make]' | \
		grep -v '=' | \
		sed 's/##/:/' | \
		awk -F '[:]' '\
		BEGIN \
			{A=""} \
			{gsub("\.make\/|\.mk","",$$1)} \
			{if ($$1!=A) { \
				print "\n\033[33m-",$$1,"\033[0m"; A=$$1\
			}} \
			{printf "\033[32m%s\t\t\t\t\t\033[37m%s\033[0m\n",$$2,$$4} \
		'


##################
# Docker compose
##################

build: ## Lance la construction des conteneurs Docker définis dans le fichier ./docker/docker-compose.yml en utilisant les variables d'environnement de ./docker/.env
	${DOCKER_COMPOSE} build

start: ## Démarre les conteneurs Docker définis dans le fichier ./docker/docker-compose.yml en utilisant les variables d'environnement de ./docker/.env
	${DOCKER_COMPOSE} start

stop: ## Arrête les conteneurs Docker définis dans le fichier ./docker/docker-compose.yml en utilisant les variables d'environnement de ./docker/.env
	${DOCKER_COMPOSE} stop

up: ## Démarre les conteneurs Docker en mode détaché (-d) et supprime les conteneurs orphelins en utilisant les variables d'environnement de ./docker/.env
	${DOCKER_COMPOSE} up -d --remove-orphans

upd: ## Démarre les conteneurs Docker en utilisant les variables d'environnement de ./docker/.env
	${DOCKER_COMPOSE} up

ps:
	${DOCKER_COMPOSE} ps

logs: ## Affiche les journaux (logs) en temps réel des conteneurs Docker définis dans le fichier ./docker/docker-compose.yml en utilisant les variables d'environnement de ./docker/.env
	${DOCKER_COMPOSE} logs -f

down: ## Arrête et supprime les conteneurs Docker définis dans le fichier ./docker/docker-compose.yml en utilisant les variables d'environnement de ./docker/.env
	${DOCKER_COMPOSE} down

harddown: ## Arrête et supprime les conteneurs Docker, les volumes et les images spécifiées dans le fichier ./docker/docker-compose.yml en utilisant les variables d'environnement de ./docker/.env
	${DOCKER_COMPOSE} down -v --rmi=all --remove-orphans

restart: ## Arrête tous les conteneurs Docker avec 'dc_stop', puis les redémarre avec 'dc_start'
	make dc_stop dc_start


##################
# Bash
##################

bash: ## Lance un shell interactif dans le conteneur Docker "php-fpm"
	${DOCKER_EXEC} -u root portfolio_php bash

mysql: ## Lance un shell interactif dans le conteneur Docker "mysql"
	${DOCKER_EXEC} portfolio_mysql bash

ssl: ## Lance un shell interactif dans le conteneur Docker "ssl" en tant qu'utilisateur root
	bash ./docker/nginx/generate_cert.sh

node: ## Lance un shell interactif dans le conteneur Docker "node"
	${DOCKER_EXEC} -u root myportfolio-node-1 sh


##################
# Bash
##################

builddev: ## Build une base dev
	${DOCKER_EXEC} portfolio_php bin/adminconsole sulu:build dev

buildprod: ## Build une base dev
	${DOCKER_EXEC} portfolio_php bin/adminconsole sulu:build prod

buildadmin: ## Build les assets de l'admin
	${DOCKER_EXEC} portfolio_php bin/adminconsole sulu:admin:update-build

getlanguage:
	${DOCKER_EXEC} portfolio_php bin/console sulu:admin:download-language

admincache: ## Reset Admin cache
	${DOCKER_EXEC} portfolio_php bin/adminconsole c:c

mediacache: ## Reset Media cache
	${DOCKER_EXEC} portfolio_php bin/websiteconsole sulu:media:format:cache:clear

##################
# Node
##################

npmInstall: ## Installe les packages npm dans le conteneur Docker "node"
	${DOCKER_NODE} npm install

npmUpdate: ## Mise à jour de npm et browserslist dans le conteneur Docker "node"
	${DOCKER_NODE} npm run update:all

assetsLint: ## Analyse le code source à l'aide de ESLint et de Stylelint en utilisant la configuration spécifiée.
	${DOCKER_NODE} npm run lint:all

assetsFormatCss: ## Formate le code source à l'aide de Stylelint en utilisant la configuration spécifiée.
	${DOCKER_NODE} npm run prettier:css

assetsFormatJs: ## Formate le code source à l'aide de ESLint en utilisant la configuration spécifiée.
	${DOCKER_NODE} npm run format:js


##################
# Backup / Restore
##################

backup: ## Backup une base
	./shell/backup.sh

restore_pigeon: ## Restore une base
	@echo "Restoring database from URL: $(url)"
	./shell/restore_pigeon.sh $(url)

restore: ## Restore une base
	@echo "Restoring database and uploads directories"
	./shell/restore.sh

assets: ## Build une base dev
	${DOCKER_EXEC} portfolio_php bin/adminconsole asset-map:compile

phpstan: ## Analyse le code source à l'aide de PHPStan en utilisant la configuration spécifiée.
	${DOCKER_EXEC} portfolio_php bash -c vendor/bin/phpstan analyse src tests -c phpstan.dist.neon

phpcs: ## Applique les corrections de style PHP-CS-Fixer aux fichiers source dans les répertoires spécifiés.
	${DOCKER_EXEC} -u root portfolio_php php vendor/bin/php-cs-fixer fix ./src


##################
# Git Hooks
##################

githooks: ## Defines git hooks path
	git config core.hooksPath .githooks
