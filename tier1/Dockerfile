FROM debian:sid

RUN echo deb http://deb.debian.org/debian/ bullseye main > /etc/apt/sources.list.d/bullseye.list && \
    echo deb http://security.debian.org/debian-security/ bullseye-security main >> /etc/apt/sources.list.d/bullseye.list && \
    echo deb http://deb.debian.org/debian/ experimental main > /etc/apt/sources.list.d/experimental.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        curl file gcc g++ python3-full python3-pip python3-dev python3-setuptools python3-wheel cython3 libseccomp-dev bzip2 gzip \
        python2 fp-compiler libxtst6 tini ca-certificates-java openjdk-8-jdk-headless openjdk-8-jre-headless \
        $([ "$(arch)" = aarch64 ] && echo binutils-arm-linux-gnueabihf) && \
    mkdir -p /etc/perl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -m judge

ENTRYPOINT ["/usr/bin/tini", "/code/run"]
