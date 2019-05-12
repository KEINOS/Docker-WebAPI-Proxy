# WebAPI-Pxory

FROM jwilder/nginx-proxy:alpine

LABEL maintainer="https://github.com/KEINOS" \
      description="Container for WebAPI. Lightweight and simple usage." \
      usage="https://github.com/KEINOS/Dockerfile_of_WebAPI-Proxy" \
      issue="https://github.com/KEINOS/Dockerfile_of_WebAPI-Proxy/issues" \
      license="MIT"

RUN rm -rf /var/cache/apk/*

# Copy docker.conf if you want to deal withmain or http contexes.
#COPY docker.conf /etc/nginx/docker.conf
COPY proxy.conf /etc/nginx/conf.d/proxy.conf
COPY healthcheck.sh /healthcheck.sh

HEALTHCHECK --interval=5m --timeout=3s CMD /healthcheck.sh
