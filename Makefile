IMPLEMENTATION ?= sbcl
VERSION ?= 1.4.15
SLIME_DIR ?= ~/quicklisp/dists/quicklisp/software/slime-v2.22

## help: Display this message
help: Makefile
	@echo " Available tasks:"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' | sed -e 's/^/\t/'
	@echo

## build: Build and tag lisp docker image
build:
	docker build --build-arg VERSION=${VERSION} -f Dockerfile.${IMPLEMENTATION} -t common-lisp-${IMPLEMENTATION}:${VERSION} .
	docker build --build-arg VERSION=${VERSION} -f Dockerfile.${IMPLEMENTATION}.ql -t common-lisp-${IMPLEMENTATION}-ql:${VERSION} .

## run: Run lisp container
run:
	docker run --rm -it -p "4005:4005" -p "4242:4242" -v ${SLIME_DIR}:/root/common-lisp/slime --hostname cl-app --name cl-app common-lisp-${IMPLEMENTATION}-ql:${VERSION}

## bash: Run bash inside the lisp container
bash:
	docker run --rm -it -v ${SLIME_DIR}:/root/common-lisp/slime common-lisp-${IMPLEMENTATION}-ql:${VERSION} /bin/bash

## up: Spin up containers
up:
	IMPLEMENTATION=${IMPLEMENTATION} VERSION=${VERSION} SLIME_DIR=${SLIME_DIR} docker-compose up -d

## down: Tear down containers
down:
	IMPLEMENTATION=${IMPLEMENTATION} VERSION=${VERSION} SLIME_DIR=${SLIME_DIR} docker-compose down

## restart: Restart containers
restart: down up

## logs: Show logs for the given services (show all if no args provided)
logs:
	IMPLEMENTATION=${IMPLEMENTATION} VERSION=${VERSION} SLIME_DIR=${SLIME_DIR} docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))
