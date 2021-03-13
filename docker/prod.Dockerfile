FROM rust:1.50.0-alpine AS builder

# Meta data
LABEL maintainer="email@mattglei.ch"
LABEL description="🚀 Really fast file sorting CLI"

# Copying over all the files
COPY . /usr/src/app
WORKDIR /usr/src/app

# Install make
# hadolint ignore=DL3018
RUN apk add --no-cache --update make
RUN rm -rf /var/cache/apk/*

# Build binary
RUN make build-prod

# hadolint ignore=DL3006,DL3007
FROM alpine:latest
COPY --from=builder /usr/src/app/target/release/full-tilt-sort .
CMD ["./full-tilt-sort"]
