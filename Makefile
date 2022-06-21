NAME = chokkalingamk/testapplication
#DOCKER_NAME = $(DOCKER_NAME)
VERSION = $(shell date +%Y%m%d)

.PHONY: build start push

build:	build-version

build-version:
	docker build -t ${NAME}:${VERSION}  .

tag-latest:
	docker tag ${NAME}:${VERSION} ${NAME}:latest

start:
	docker run -it --rm ${NAME}:${VERSION}/bin/bash

login:
	echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_NAME} --password-stdin

push:	login build-version tag-latest
	docker push ${NAME}:${VERSION}; docker push ${NAME}:latest
