# function for creating version files with version string and date
ver_file = echo "1.0.0" > $(1) && date +%Y-%m-%d >> $(1)

all: clean build/image.txt

clean:
	rm -rf build
	rm -rf docs

build_dir:
	mkdir -p build

build/base.txt: build_dir
	docker build --progress=plain -t ghcr.io/jensberg047/jensberg047.github.io.base:latest -f Dockerfile-base . && $(call ver_file, $@)

build/builder.txt: build/base.txt
	docker build --progress=plain -t ghcr.io/jensberg047/jensberg047.github.io.builder:latest -f Dockerfile-builder . && $(call ver_file, $@)

build/image.txt: build/builder.txt
	docker build --progress=plain -t ghcr.io/jensberg047/jensberg047.github.io:latest -f Dockerfile . && $(call ver_file, $@)

build/run.txt: build/image.txt
	docker run --rm -d --name jensberg047.github.io -p 32768:80 ghcr.io/jensberg047/jensberg047.github.io:latest && $(call ver_file, $@)

build/update.txt: build_dir
	docker stop jensberg047.github.io.builder
	docker pull ghcr.io/jensberg047/jensberg047.github.io.builder:main && $(call ver_file, $@)

/docs/index.html:
	docker run --rm \
  --name jensberg047.github.io.builder \
  --volume $(shell pwd):/usr/src/app \
  ghcr.io/jensberg047/jensberg047.github.io.builder:main \
  R -e 'rmarkdown::render_site()'
