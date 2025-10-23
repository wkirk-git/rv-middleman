.PHONY: build run shell

build:
	docker buildx build --platform linux/arm64 -t rv-middleman .

run:
	docker run -it rv-middleman /bin/bash
