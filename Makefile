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
yarn-audit:
	$(YARN) audit

webserver:
	symfony server:start --allow-http --no-tls --document-root=dist/ --daemon
webserver-stop:
	symfony server:stop
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

# see: https://gist.github.com/ErickPetru/b1b3138ab0fc6c82cd19ea3a1a944ba6
prod:
	clear
	sudo rm -rf dist
	git worktree prune
	git worktree add -f ./dist gh-pages
	$(YARN) encore production
deploy-gh-pages:
	cd dist && git add --all  && git commit -m "Deploy on gh-pages updated" && git push origin gh-pages

clean:
	sudo rm -rf dist/*

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
