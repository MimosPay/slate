run_slate:
	@echo "Run Slate at http://localhost:4567 ..."
	#docker run -d --rm --name slate -p 4567:4567 -v $(CURDIR)/build:/srv/slate/build -v $(CURDIR)/source:/srv/slate/source slate
	docker run -d --rm --name slate -p 4567:4567 \
		-v $(CURDIR)/build:/srv/slate/build \
		-v $(CURDIR)/source:/srv/slate/source \
		-v $(CURDIR)/lib:/srv/slate/lib \
		-v ${CURDIR}/locales:/srv/slate/locales slate

stop_slate:
	@echo "Stop Slate..."
	docker stop slate

build_slate:
	@echo "Build Slate..."
	docker exec -it slate /bin/bash -c "bundle exec middleman build"

logging_slate:
	@echo "View Slate log..."
	docker logs -f slate

build_docker_image:
	@echo "Build docker image with buildkit enabled, docker version should be 18.09 or higher"
	DOCKER_BUILDKIT=1 docker build --build-arg BUILD_VERSION=1 . -t slate

build_docker_image_mirror:
	@echo "Build docker image from mirror..."
	docker build -f Dockerfile.mirror . -t slate

build_docker_image_original:
	@echo "Build docker image from original source..."
	docker build -f Dockerfile.original . -t slate
