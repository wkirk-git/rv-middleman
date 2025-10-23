.PHONY: build run shell

build:
	docker buildx build --platform linux/amd64,linux/arm64 -t rv-middleman .

run:
	docker run -it -p 4567:4567 rv-middleman

shell:
	docker run -it --entrypoint /bin/bash rv-middleman
