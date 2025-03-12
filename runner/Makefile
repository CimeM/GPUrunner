# Makefile for Docker image management

# Variables
IMAGE_NAME := whale-runner
TAG := latest
DOCKERFILE := Dockerfile
RUNNER_VERSION=2.322.0

# Default target
.PHONY: all
all: build

# Build the Docker image
.PHONY: build
build:
	docker build -t $(IMAGE_NAME):$(TAG) \
	--build-arg RUNNER_VERSION=$(RUNNER_VERSION) \
	--network=host \
	-f $(DOCKERFILE) .

# Remove the Docker image
.PHONY: clean
clean:
	docker rmi $(IMAGE_NAME):$(TAG)

# Push the Docker image to a registry (assuming you're logged in)
.PHONY: push
push:
	docker push $(IMAGE_NAME):$(TAG)

# Pull the Docker image from a registry
.PHONY: pull
pull:
	docker pull $(IMAGE_NAME):$(TAG)

# Run the Docker container
.PHONY: run
run:
	docker run -it --rm $(IMAGE_NAME):$(TAG)

# Install systemd service
.PHONY: installservice
run: 
    mkdir /usr/local/bin/runner
	cp ./docker-compose.yaml /usr/local/bin/runner/docker-compose.yaml
    cp systemd.runner.service/github-runner.service /etc/systemd/system/github-runner.service
	cp systemd.runner.service/start.sh /usr/local/bin/runner/github-runner-start.sh
	cp systemd.runner.service/stop.sh /usr/local/bin/runner/github-runner-stop.sh
	sudo systemctl enable github-runner.service
	sudo systemctl start github-runner.service

# Uninstall systemd service
.PHONY: uninstallservice
uninstall:
	sudo systemctl stop github-runner.service
	sudo systemctl disable github-runner.service
	sudo rm /etc/systemd/system/github-runner.service
	cp /usr/local/bin/runner/docker-compose.yaml
	sudo rm /usr/local/bin/runner/github-runner-start.sh
	sudo rm /usr/local/bin/runner/github-runner-stop.sh
	sudo systemctl daemon-reload
	sudo systemctl reset-failed

# Restart systemd service
.PHONY: restartservice
run: 
    systemctl restart github-runner.service

# Display help information
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  build  - Build the Docker image"
	@echo "  clean  - Remove the Docker image"
	@echo "  push   - Push the Docker image to a registry"
	@echo "  pull   - Pull the Docker image from a registry"
	@echo "  run    - Run the Docker container"
	@echo "  help   - Display this help information"
