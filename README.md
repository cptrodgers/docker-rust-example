# PRIVATE LIB, DOCKER for RUST

This is an example that using ssh in Docker build. It also re-uses caching system of Rust instead of focus caching system of Docker.
This example will help you to create a docker base for run testing, deployment in your CI/CD system.

## Init (Just do once)
I assume that you are using rust 1.42.
```shell script
docker tag rust:1.42 rust-base:1.42
ssh-add -K ~/.ssh/id_rsa
```

## Build
```shell script
export DOCKER_BUILDKIT=1
docker build --ssh default . -t rust-base:1.42
```

The output will look like:
```shell script
[+] Building 28.8s (16/16) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                   0.0s
 => => transferring dockerfile: 486B                                                                                                                                   0.0s
 => [internal] load .dockerignore                                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                                        0.0s
 => resolve image config for docker.io/docker/dockerfile:experimental                                                                                                  3.2s
 => CACHED docker-image://docker.io/docker/dockerfile:experimental@sha256:787107d7f7953cb2d95ee81cc7332d79aca9328129318e08fc7ffbd252a20656                             0.0s
 => [internal] load metadata for docker.io/library/rust-base:1.42                                                                                                      0.0s
 => [internal] load metadata for docker.io/library/rust:1.42                                                                                                           0.0s
 => [current-build 1/6] FROM docker.io/library/rust:1.42                                                                                                               0.0s
 => [internal] load build context                                                                                                                                      0.1s
 => => transferring context: 9.13kB                                                                                                                                    0.1s
 => [pre-build 1/2] FROM docker.io/library/rust-base:1.42                                                                                                              0.0s
 => CACHED [current-build 2/6] WORKDIR /app                                                                                                                            0.0s
 => CACHED [pre-build 2/2] WORKDIR /app                                                                                                                                0.0s
 => CACHED [current-build 3/6] COPY --from=pre-build /app /app                                                                                                         0.0s
 => CACHED [current-build 4/6] COPY --from=pre-build /usr/local/cargo /usr/local/cargo                                                                                 0.0s
 => [current-build 5/6] ADD . /app                                                                                                                                     0.1s
 => [current-build 6/6] RUN --mount=type=ssh cargo build --all                                                                                                        24.5s
 => exporting to image                                                                                                                                                 0.5s
 => => exporting layers                                                                                                                                                0.5s
 => => writing image sha256:68f3eec19813f48992708bd0e6137626c092f1603eb80cd0d755a301011abd70                                                                           0.0s
 => => naming to docker.io/library/rust-base:1.42                                                                                                                      0.0s
```

## Note:
If you have a problem with ssh config, you can try to put this config into ssh config file:
```shell script
Host *
UseKeychain yes
AddKeysToAgent yes
IdentityFile ~/.ssh/id_rsa
```

This is the blog that explains for this example. [Link](https://rodgers.zone/using-docker-and-git-in-rust-project/)
