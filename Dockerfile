# STAGE 1: Build
FROM golang:1.15.3-alpine3.12 AS build

# Install Node and NPM.
RUN apk update && apk upgrade && apk add --no-cache git nodejs bash npm

# Get dependencies for Go part of build
RUN go get -u github.com/jteeuwen/go-bindata/...

WORKDIR /go/src/github.com/aubonbeurre/kuard

# Copy all sources in
COPY . .

# This is a set of variables that the build script expects
ENV VERBOSE=0
ENV PKG=github.com/aubonbeurre/kuard
ENV ARCH=amd64
ENV VERSION=test

# Do the build. Script is part of incoming sources.
# RUN build/build.sh
RUN ["/bin/bash", "-c", "build/build.sh"]

# STAGE 2: Runtime
#FROM alpine

#USER nobody:nobody
#COPY --from=build /go/bin/kuard /kuard

#CMD [ "/kuard" ]
CMD ping localhost