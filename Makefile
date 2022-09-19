
CURRENT_UID = $(shell id -u):$(shell id -g)
DIST_DIR ?= $(CURDIR)/dist

REPOSITORY_OWNER ?= dduportal
REPOSITORY_NAME ?= cv
OWNER_NAME ?= "Damien DUPORTAL"

REPOSITORY_URL ?= https://github.com/$(REPOSITORY_OWNER)/$(REPOSITORY_NAME)
CV_URL ?= https://$(REPOSITORY_OWNER).github.io/$(REPOSITORY_NAME)
SHORT_OWNER_NAME ?= $(shell echo "$(OWNER_NAME)" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

ifdef GITHUB_REF
	GIT_REF = $(GITHUB_REF:refs/heads/%=%)
else
	GIT_REF = $(shell git rev-parse --abbrev-ref HEAD)
endif
SOURCE_URL ?= $(REPOSITORY_URL)/tree/$(GIT_REF)

export CV_URL REPOSITORY_URL SOURCE_URL SHORT_OWNER_NAME CURRENT_UID

.PHONY: all
all: clean build test

$(DIST_DIR):
	mkdir -p $(DIST_DIR)

.PHONY: build
build: html pdf

.PHONY: html
html: $(DIST_DIR)
	docker-compose up html

.PHONY: pdf
pdf: $(DIST_DIR)
	docker-compose up pdf

.PHONY: clean
clean:
	rm -rf $(DIST_DIR)

.PHONY: test
test: $(DIST_DIR)/index.html
	docker-compose up --build test
