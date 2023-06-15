FROM jensberg047.github.io.builder:latest as builder
RUN Rscript -e 'rmarkdown::render_site()'

FROM nginx:latest
EXPOSE 80
COPY --from=builder docs /usr/share/nginx/html
