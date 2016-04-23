FROM alpine:3.3
MAINTAINER Alexander Jung-Loddenkemper <alexander@julo.ch>

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add --no-cache tar ca-certificates bash docker

ENV DOCKER_GEN_VERSION 0.7.0
RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
    && tar -C /usr/local/bin -xvzf docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
    && rm /docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

RUN mkdir -p /opt/caddy-gen /etc/caddy
WORKDIR /opt/caddy-gen

VOLUME ['/etc/caddy']

COPY . /opt/caddy-gen
CMD /usr/local/bin/docker-gen -notify ./reload.sh -notify-output -only-exposed -watch Caddyfile.tmpl /etc/caddy/Caddyfile
