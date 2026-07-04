.PHONY: dry-run
dry-run:
	stow --dir=. --target=$(HOME) --simulate --verbose . 

.PHONY: stow
stow:
	mkdir -p $(HOME)
	stow --dir=. --target=$(HOME) --verbose . 

.PHONY: unstow
unstow:
	stow --dir=. --target=$(HOME) --delete --verbose . 

.PHONY: restow
restow:
	mkdir -p $(HOME)
	stow --dir=. --target=$(HOME) --restow --verbose . 

.PHONY: tree
tree:
	tree -a -I '.git' 
