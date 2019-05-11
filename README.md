[![](https://img.shields.io/docker/cloud/automated/keinos/webapi-proxy.svg)](https://hub.docker.com/r/keinos/webapi-proxy "Docker Hub") [![](https://img.shields.io/docker/cloud/build/keinos/webapi-proxy.svg)](https://hub.docker.com/r/keinos/webapi-proxy/builds "See Build Status")

# Dockerfile of WebAPI-Proxy

Simple usage and lightweight Web API server. Especially to **provide docker containers as API endpoint**.

```text
http://your.sample.com/[container_name]/
```

- Docker Image: `keinos/webapi-proxy`
- Repositories:
  - Image: https://hub.docker.com/r/keinos/webapi-proxy @ Docker Hub
  - Source: https://github.com/KEINOS/Dockerfile_of_WebAPI-Proxy @ GitHub
- Issues: https://github.com/KEINOS/Dockerfile_of_WebAPI-Proxy/issues @ GitHub
- Note: This is a customized image of [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy).

## Usage with Docker Compose

```yaml
version: '3'

services:
  nginx-proxy:
    image: keinos/webapi-proxy
    ports:
      - "8000:80"
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro

  app1:
    container_name: app1
    image: keinos/mini-php7
    volumes:
      - ./App-1/index.php:/app/htdocs/index.php

```

With the `docker-compose.yml` above, you will be able to access containers like below.

```shellsession
$ docker-compose up -d
...
$ curl http://localhost:8000/app1/
Hello World! I'm App-1!

```

The `index.php` of the "App-1":

```php
<?php

header("Content-Type: text/plain");

echo 'Hello World! I\'m App-1!' . PHP_EOL;

```
