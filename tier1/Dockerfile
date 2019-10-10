FROM debian:buster

RUN apt-get update && \
    apt-get install -y curl python3-pip python3-dev cython3 libseccomp-dev \
        python2 openjdk-11-jdk-headless clang && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/code/run"]
