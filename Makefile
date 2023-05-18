APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=tkachovua
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETS_ARCH ?= linux/amd64 #linux/arm64 darwin/amd64 windows/amd64 #"shell dpkg --print-architecture"

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
	CGO_ENABLED=0 GOOS=$(word 1,$(subst /, ,$(TARGETS_ARCH))) GOARCH=$(word 2,$(subst /, ,$(TARGETS_ARCH))) go build -v -o kbot-$(word 1,$(subst /, ,$(TARGETS_ARCH)))-$(word 2,$(subst /, ,$(TARGETS_ARCH))) -ldflags "-X="github.com/tkachovua/kbot/cmd.appVersion=${VERSION}
	
image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETS_ARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETS_ARCH}

clean:
	rm -rf kbot*
#docker rmi <IMAGE_TAG>