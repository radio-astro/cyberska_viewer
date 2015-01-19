DOCKER_REPO=gijzelaerr/cyberska_viewer

.PHONY: build clean

all: build

build:
		docker build -t ${DOCKER_REPO} .

clean:
	docker rmi ${DOCKER_REPO}

run:
	docker run -it -v `pwd`/fits:/fits:ro -p 80:80 -p 8080:8080 ${DOCKER_REPO}

push:
	docker push ${DOCKER_REPO}



