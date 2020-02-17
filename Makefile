NODE_CONTAINER=node
NODE=docker run -it --rm  -v "$(PWD)":/usr/src/app -w /usr/src/app $(NODE_CONTAINER) nodejs
YARN=docker run -it --rm  -v "$(PWD)":/usr/src/app -w /usr/src/app $(NODE_CONTAINER) yarn
NPM=docker run -it --rm  -v "$(PWD)":/usr/src/app -w /usr/src/app $(NODE_CONTAINER) npm

.PHONY: build watch prod

all: clean build

install-docker-node:
	docker pull $(NODE_CONTAINER)
	$(NPM) set init.author.name "Alister Bulman"
	$(NPM) set init.author.email "alister@abulman.co.uk"
	$(NPM) set init.author.url "https://abulman.co.uk"
	$(NPM) set init.license "MIT"
	$(NPM) set init.version "1.0.0"
# install-yarn:
# 	#curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
# 	#echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# 	#sudo apt-get update && sudo apt-get install yarn
# 	$(YARN) add @symfony/webpack-encore --dev
yarn-install:
	$(YARN) install
yarn-outdated:
	$(YARN) outdated
yarn-upgrade:
	$(YARN) upgrade

webserver:
	symfony serve --allow-http --no-tls --document-root=dist/ --daemon #nas.abulman.co.uk:8000
webserver-logs:
	symfony server:log

assets: build
dev: build
build:
	clear
	$(YARN) encore dev
watch:
	clear
	$(YARN) encore dev --watch
prod:
	clear
	$(YARN) encore production

# Run install on the new ansible-test server, on local Vagrant
# deploy-vagrant:
# 	bundle exec cap vagrant deploy
# deploy:
# 	bundle exec cap prod deploy
# deploy-trace:
# 	bundle exec cap prod deploy --trace
# deploy-check:
# 	bundle exec cap prod deploy:check
clean:
	sudo rm -rf dist/

########################################################################
# from: https://github.com/kvz/fakefile/blob/master/Makefile

# define npm_script_targets
# TARGETS := $(shell ${NODE} -e 'for (var k in require("./package.json").scripts) {console.log(k.replace(/:/g, "-"));}')
# $$(TARGETS):
# 	${NPM} run $(subst -,:,$(MAKECMDGOALS))

# .PHONY: $$(TARGETS)
# endef

# $(eval $(call npm_script_targets))

# # These npm run scripts are available, without needing to be mentioned in `package.json`
# install:
# 	${NPM} install
