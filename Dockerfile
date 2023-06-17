FROM ghcr.io/wilsonify/jensberg047.github.io.builder:latest as builder
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN R -e 'rmarkdown::render_site()'

FROM ghcr.io/wilsonify/jensberg047.github.io.base:latest
RUN apt-get install -y nginx
EXPOSE 80
COPY --from=builder /usr/src/app/docs /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]