.PHONY: deps build clean test-output default help format work-vsc work-cursor

default: help

deps: # Install dependencies for local dev
	npm install

build: # Build the VS Code theme
	mkdir -p out
	npm run package

clean: # Remove build products
	rm -rf out

help: # List available targets
	@awk '/^[a-zA-Z0-9_\/-]+:/ { \
		target = $$1; \
		sub(/:.*/, "", target); \
		if (target == "default") next; \
		comment = $$0; \
		sub(/^[^#]*#?/, "", comment); \
		printf "\033[1m%s\033[0m\t%s\n", target, comment; \
	}' Makefile | sort

format: # Format code using Prettier
	npx prettier --write . "!**/.vscode/**"

work-vsc:
	code --extensionDevelopmentPath=$$(pwd) .

work-cursor:
	cursor --extensionDevelopmentPath=$$(pwd) .
