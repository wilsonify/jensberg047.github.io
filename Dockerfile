FROM ghcr.io/jensberg047/jensberg047.github.io.builder:main as builder
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN apt-get install -y pandoc
RUN R -e 'rmarkdown::render_site()'

FROM nginx:latest
EXPOSE 80
COPY --from=builder /usr/src/app/docs /usr/share/nginx/html