
base:
	docker build -t jensberg047.github.io.base:latest -f Dockerfile-base .

builder: base
	docker build -t jensberg047.github.io.builder:latest -f Dockerfile-builder .

image: builder
	docker build -t jensberg047.github.io:latest -f Dockerfile .
