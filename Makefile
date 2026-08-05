.DEFAULT_GOAL := help

.PHONY: help
help: ## List available commands
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z0-9_-]+:.*## / {printf "  %-18s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: stow
stow: ## Install tracked agent configuration as symlinks under $(HOME); pass dry=1 to simulate
	mkdir -p $(HOME)
	stow --dir=. --target=$(HOME) $(if $(dry),--simulate) --verbose .

.PHONY: unstow
unstow: ## Remove symlinks created by GNU Stow from $(HOME); pass dry=1 to simulate

	stow --dir=. --target=$(HOME) $(if $(dry),--simulate) --delete --verbose .

.PHONY: restow
restow: ## Refresh symlinks after files are added, removed, or moved; pass dry=1 to simulate

	mkdir -p $(HOME)
	stow --dir=. --target=$(HOME) $(if $(dry),--simulate) --restow --verbose .

.PHONY: stow-claude-skills
stow-claude-skills: ## Link agent skills into $(HOME)/.claude/skills; pass dry=1 to simulate
	stow --dir=.agents --target=$(HOME)/.claude/skills $(if $(dry),--simulate) --verbose skills

.PHONY: tree
tree: ## Print the repository tree; pass s=<path> to limit output to a subdirectory
	tree -a -I '.git'  $(if $(s), $(s))
