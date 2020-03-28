.PHONY: build

SABNZBD_VERSION := 2.3.9
BUILD_ARCHS := linux/arm64,linux/arm/v7

# linux/amd64,linux/arm64,
build:
	docker buildx build --platform $(BUILD_ARCHS) -t bboerst/sabnzbd-docker-arm:$(SABNZBD_VERSION) -f Dockerfile . --push