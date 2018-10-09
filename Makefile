SA=`pwd`/sa.sh
LA=`pwd`/la.sh

.PHONY: serve install_theme test alter help
.DEFAULT_GOAL := help

# Server side
server_install: ## install server program
	@$(SA) download && $(SA) install 

server_start: ## run server
	@$(SA) restart

server_status: ## show server status
	@$(SA) status

server_stop: ## stop server
	@$(SA) stop

server_uninstall: ## uninstall server
	@$(SA) uninstall

# local side
local_install: ## install local program
	@$(LA) download && $(LA) install 

local_start: ## run local
	@$(LA) restart

local_status: ## show local status
	@$(LA) status

local_stop: ## stop local
	@$(LA) stop

local_uninstall: ## uninstall server
	@$(LA) uninstall

clean: ## remove download files
	@$(LA) clean

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
