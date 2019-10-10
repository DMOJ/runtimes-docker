FROM debian:buster-slim

RUN apt-get update && \
    apt-get install -y curl python3-pip python3-dev cython3 libseccomp-dev && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/code/run"]
