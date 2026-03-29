FROM golang:1-alpine AS build

USER 1000
WORKDIR /galene

ADD https://github.com/jech/galene.git#550c58ad854c4bf8f6ff5d1d3d2479801c19e21f /galene
ARG CGO_ENABLED=0
ARG GOCACHE=/gocache

RUN --mount=type=cache,uid=1000,gid=1000,target=/gocache \
    go build -ldflags='-s -w'

FROM scratch

COPY --from=build --chmod=0555 --chown=0:0 /galene/galene /galene

USER 1000
WORKDIR /data
VOLUME /galene

EXPOSE 8443

ENTRYPOINT ["/galene"]
