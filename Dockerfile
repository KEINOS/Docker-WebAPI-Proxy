# WebAPI-Pxory

FROM jwilder/nginx-proxy:alpine

LABEL maintainer="https://github.com/KEINOS" \
      description="Container for WebAPI. Lightweight and simple usage." \
      usage="https://github.com/KEINOS/Dockerfile_of_WebAPI-Proxy" \
      issue="https://github.com/KEINOS/Dockerfile_of_WebAPI-Proxy/issues" \
      license="MIT"

RUN rm -rf /var/cache/apk/*

#COPY nginx.conf /etc/nginx/nginx.conf
COPY proxy.conf /etc/nginx/conf.d/proxy.conf
