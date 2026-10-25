FROM golang:1-alpine AS build

USER 1000
WORKDIR /galene

ADD https://github.com/jech/galene.git#e2bc84f26d4f5f92a6deb9cd6cfc27acae2cacc4 /galene
ARG CGO_ENABLED=0
ARG GOCACHE=/gocache

RUN --mount=type=cache,uid=1000,gid=1000,target=/gocache \
    go build -ldflags='-s -w'

FROM scratch

COPY --from=build --chmod=0555 --chown=0:0 /galene/galene /galene

USER 1000

EXPOSE 8443

ENTRYPOINT ["/galene"]
CMD [ ]
