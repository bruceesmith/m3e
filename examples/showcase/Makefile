
File: Makefile

## build: build the application
.PHONY: build
build: gleam

## build-prod: build the application for production (minified)
.PHONY: build-prod
build-prod: gleam-prod

## gleam: translate to JS
.PHONY: gleam
gleam:
	gleam run -m lustre/dev build --no-html app

## gleam-prod: translate to JS and minify
.PHONY: gleam-prod
gleam-prod:
	gleam run -m lustre/dev build --minify --no-html app

## tailwind: generate the CSS
.PHONY: tailwind
tailwind:
	tailwind -i src/base.css -o dist/app.css

## tailwind-prod: generate the CSS for production
.PHONY: tailwind-prod
tailwind-prod:
	tailwind -i src/base.css -o dist/app.min.css --minify

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
