# syntax=docker/dockerfile:experimental
FROM rust-base:1.42 as pre-build

WORKDIR /app
######################################
FROM rust:1.42 as current-build
WORKDIR /app

# This command will help us avoid re-build dependencies
COPY --from=pre-build /app /app

# This command will help us avoid re-udpate and re-download dependencies
COPY --from=pre-build /usr/local/cargo /usr/local/cargo

ADD . /app

RUN --mount=type=ssh cargo build --all
