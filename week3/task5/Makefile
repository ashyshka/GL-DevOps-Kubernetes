APP="kbot"
REGISTRY="europe-central2-docker.pkg.dev/gl-devops-and-kubernetes/k3s-k3d"
#VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
VERSION=$(shell git rev-parse --short HEAD)

clone:
	rm -rf kbot
	git clone https://github.com/ashyshka/kbot
	sed -i 's\1.21.4\1.20\g' kbot/go.mod

format:
	cd kbot && gofmt -s -w ./

get:
	cd kbot && go get

lint:
	cd kbot && golint

test:
	cd kbot && go test -v

linux: clone format get
	@printf "$GTarget OS/ARCH: $Rlinux/${TARGETARCH}$D\n"
	docker build --build-arg TARGETOS=linux --build-arg TARGETARCH=${TARGETARCH} --build-arg VERSION=${VERSION} -t ${REGISTRY}/${APP}:${VERSION}-linux-${TARGETARCH} .

windows: clone format get
	@printf "$GTarget OS/ARCH: $Rwindows/${TARGETARCH}$D\n"
	docker build --build-arg TARGETOS=windows --build-arg TARGETARCH=${TARGETARCH} --build-arg VERSION=${VERSION} -t ${REGISTRY}/${APP}:${VERSION}-windows-${TARGETARCH} .

darwin:format get
	@printf "$GTarget OS/ARCH: $Rdarwin/${TARGETARCH}$D\n"
	docker build --build-arg TARGETOS=darwin --build-arg TARGETARCH=${TARGETARCH} --build-arg VERSION=${VERSION} -t ${REGESTRY}/${APP}:${VERSION}-darwin-${TARGETARCH} .

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	@rm -rf kbot; \
	IMG=$$(docker images -q | head -n 1); \
	if [ -n "$${IMG}" ]; then  docker rmi -f $${IMG}; else printf "$RImage not found$D\n"; fi
