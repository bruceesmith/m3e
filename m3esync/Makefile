
File: Makefile

# Change these variables as necessary.
main_package_path = .
binary_name = "m3esync"

.PHONY: confirm
confirm:
	@echo -n 'Are you sure? [y/N] ' && read ans && [ $${ans:-N} = y ]

## audit: run quality control checks
.PHONY: audit
audit: test generate
	go mod tidy -diff
	go mod verify
	@test -z "$(gofmt -l .)" 
	go vet ./...
	go tool staticcheck -checks all ./...
	go tool govulncheck -show verbose ./...
	go tool goreportcard-cli -v ./...
	go tool scc

## build: build the application
.PHONY: build
build: generate
	go build -a -tags osusergo,netgo -ldflags "-s -X 'github.com/bruceesmith/echidna.BuildDate=$(shell date)' -w -extldflags '-static'" ${main_package_path}

## generate: run all go generate commands
generate:
	go generate ./...

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## library: trial compilation of a library
library: audit
	GOOS=linux GOARCH=amd64 go build ./...

## no-dirty: check for uncommitted changes
.PHONY: no-dirty
no-dirty:
	@test -z "$(shell git status --porcelain)"

## prod: deploy the application to production
.PHONY: prod 
prod: audit no-dirty
	GOOS=linux GOARCH=amd64 go build -a -tags osusergo,netgo -ldflags "-s -X 'github.com/bruceesmith/echidna.BuildDate=$(shell date)' -w -extldflags '-static'" ${main_package_path}

## push: push changes to the remote Git repository
.PHONY: push
push: confirm audit no-dirty
	git push

## run: run the  application
.PHONY: run
run: build
	/tmp/${binary_name}

## fix: apply any new Go features / capabilities
.PHONY: fix
fix:
	go fix ./...

## run/live: run the application with reloading on file changes
.PHONY: run/live
run/live:
	go run github.com/cosmtrek/air@v1.43.0 \
		--build.cmd "make build" --build.bin "/tmp/${binary_name}" --build.delay "100" \
		--build.exclude_dir "" \
		--build.include_ext "go, tpl, tmpl, html, css, scss, js, ts, sql, jpeg, jpg, gif, png, bmp, svg, webp, ico" \
		--misc.clean_on_exit "true"

## test: run all tests
.PHONY: test
test:
	go test -race -buildvcs -cover ./...

## test/verbose: run all tests with verbose output
.PHONY: test
test/verbose:
	go test -v -race -buildvcs -cover ./...

## tidy: tidy modfiles and format .go files
.PHONY: tidy
tidy:
	go mod tidy -v
	go fmt ./...
