
base:
	docker build --progress=plain -t ghcr.io/wilsonify/jensberg047.github.io.base:latest -f Dockerfile-base .

builder: base
	docker build --progress=plain -t ghcr.io/wilsonify/jensberg047.github.io.builder:latest -f Dockerfile-builder .

image: builder
	docker build --progress=plain -t ghcr.io/wilsonify/jensberg047.github.io:latest -f Dockerfile .

/docs/index.html:
	docker run --rm \
  --name jensberg047.github.io.builder \
  --volume $(shell pwd):/usr/src/app \
  ghcr.io/wilsonify/jensberg047.github.io.builder:main \
  R -e 'rmarkdown::render_site()'
