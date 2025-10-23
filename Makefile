.PHONY: build run shell

build:
	docker buildx build --platform linux/arm64 -t rv-middleman .

run:
	docker run -it -p 4567:4567 -v $(PWD)/source:/home/middleman/source rv-middleman

shell:
	docker run -it --entrypoint /bin/bash rv-middleman
