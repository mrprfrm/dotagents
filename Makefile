.DEFAULT_GOAL := help

.PHONY: help
help: ## List available commands
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z0-9_-]+:.*## / {printf "  %-18s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: dry-run
dry-run: ## Preview links that GNU Stow would create under $(HOME)
	stow --dir=. --target=$(HOME) --simulate --verbose . 

.PHONY: stow
stow: ## Install tracked agent configuration as symlinks under $(HOME)
	mkdir -p $(HOME)
	stow --dir=. --target=$(HOME) --verbose . 

.PHONY: unstow
unstow: ## Remove symlinks created by GNU Stow from $(HOME)
	stow --dir=. --target=$(HOME) --delete --verbose . 

.PHONY: restow
restow: ## Refresh symlinks after files are added, removed, or moved
	mkdir -p $(HOME)
	stow --dir=. --target=$(HOME) --restow --verbose . 

.PHONY: tree
tree: ## Print the repository tree; pass s=<path> to limit output to a subdirectory
	tree -a -I '.git'  $(if $(s), $(s))
