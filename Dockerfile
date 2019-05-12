# WebAPI-Pxory

FROM jwilder/nginx-proxy:alpine

LABEL maintainer="https://github.com/KEINOS" \
      description="Container for WebAPI. Lightweight and simple usage." \
      usage="https://github.com/KEINOS/Dockerfile_of_WebAPI-Proxy" \
      issue="https://github.com/KEINOS/Dockerfile_of_WebAPI-Proxy/issues" \
      license="MIT"

RUN rm -rf /var/cache/apk/* && \
    mkdir -p /var/www/html && \
    echo '<h1>WebAPI Proxy</h1>' > /var/www/html/index.html

EXPOSE 80

# Copy docker.conf if you want to deal withmain or http contexes.
COPY nginx.conf /etc/nginx/nginx.conf
COPY proxy.conf /etc/nginx/conf.d/proxy.conf
COPY healthcheck.sh /healthcheck.sh

HEALTHCHECK --interval=5m --timeout=151s CMD /healthcheck.sh
