APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=gcr.io/spartan-context-384713
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETS_ARCH?=linux/amd64 linux/arm64 darwin/amd64 darwin/arm64 windows/amd64 windows/arm64 windows linux darwin

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v 

get:
	go get

.PHONY: $(TARGETS_ARCH)

#build:   

$(TARGETS_ARCH): format get
	@echo "Building for $@..."
	CGO_ENABLED=0 GOOS=$(word 1,$(subst /, ,$@)) GOARCH=$(word 2,$(subst /, ,$@)) go build -v -o kbot -ldflags "-X="github.com/tkachovua/kbot/cmd.appVersion=${VERSION}
	
image:
	docker build -t ${REGISTRY}/${APP}:${VERSION} .

push:
	docker push ${REGISTRY}/${APP}:${VERSION}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}