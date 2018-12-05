# Docker PHP-FPM 7.2 & Nginx 1.14 on Alpine Linux

Build on [Alpine Linux](http://www.alpinelinux.org/).

Usage
-----
Start the Docker containers:

Run :

```
docker run -p 80:80 ramadhan/docker-php7.2-nginx-alpine:latest
```

Docker Compose:

```
version: "2"
services: 
  web:
    image: "ramadhan/docker-php7.2-nginx-alpine:latest"
    container_name: web-rama
    ports:
        - "80:80"
        - "443:443"
```


