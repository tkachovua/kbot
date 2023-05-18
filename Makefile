APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=gcr.io/spartan-context-384713
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETS_ARCH?=linux/amd64#linux/arm64 darwin/amd64 windows/amd64 #"shell dpkg --print-architecture"

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v 

get:
	go get

.PHONY: build

build:  format get 
	@echo "Building for $(TARGETS_ARCH)..."
	CGO_ENABLED=0 GOOS=$(word 1,$(subst /, ,$(TARGETS_ARCH))) GOARCH=$(word 2,$(subst /, ,$(TARGETS_ARCH))) go build -v -o kbot -ldflags "-X="github.com/tkachovua/kbot/cmd.appVersion=${VERSION}
	
image:
	docker build -t ${REGISTRY}/${APP}-${TARGETS_ARCH}:${VERSION} .

push:
	docker push ${REGISTRY}/${APP}-${TARGETS_ARCH}:${VERSION}

clean:
	rm -rf kbot*
	docker rmi ${REGISTRY}/${APP}-${TARGETS_ARCH}:${VERSION}