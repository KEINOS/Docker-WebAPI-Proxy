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

# Over-riding confs
COPY files_include/nginx.conf /etc/nginx/nginx.conf
COPY files_include/proxy.conf /etc/nginx/conf.d/default.conf

# Default server context
COPY files_include/proxy.conf /etc/nginx/conf.d/proxy.conf

# Health check
COPY files_include/healthcheck.sh /healthcheck.sh
# HEALTHCHECK --interval=5m --timeout=151s CMD /healthcheck.sh
