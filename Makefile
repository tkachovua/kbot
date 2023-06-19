APP=$(shell basename $(shell git remote get-url origin))
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
REGISTRY=tkachovua
PROJECT_ID=spartan-context-384713
IMAGE_TAG=latest
TARGETOS=linux
TARGETARCH=amd64
CGO_ENABLED=0

linux:
	${MAKE} build TARGETOS=linux TARGETARCH=${TARGETARCH} 

macos:
	${MAKE} build TARGETOS=darwin TARGETARCH=${TARGETARCH}

windows:
	${MAKE} build TARGETOS=windows TARGETARCH=${TARGETARCH} CGO_ENABLED=1

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v 

get:
	go get

build:  format get 
	CGO_ENABLED=${CGO_ENABLED} GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/tkachovua/kbot/cmd.appVersion=${VERSION}-${TARGETARCH}

image:
#docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg CGO_ENABLED=${CGO_ENABLED} --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}
#docker build -t ${IMAGE_TAG} .
	docker build -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH} .

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}
#	gcloud auth login
#	gcloud config set project ${PROJECT_ID}
#	gcloud auth configure-docker
#	docker push ${IMAGE_TAG}

clean:
	rm -rf kbot
#docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
	docker rmi ${IMAGE_TAG}