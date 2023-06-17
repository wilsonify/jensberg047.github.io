
base:
	docker build --progress=plain -t jensberg047.github.io.base:latest -f Dockerfile-base .

builder: base
	docker build --progress=plain -t  jensberg047.github.io.builder:latest -f Dockerfile-builder .

image: builder
	docker build --progress=plain -t  jensberg047.github.io:latest -f Dockerfile .
