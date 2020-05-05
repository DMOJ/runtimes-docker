FROM debian:sid

RUN echo deb http://deb.debian.org/debian/ stretch main > /etc/apt/sources.list.d/stretch.list && \
    echo deb http://security.debian.org/debian-security stretch/updates main >> /etc/apt/sources.list.d/stretch.list && \
    echo 'APT::Default-Release "sid";' > /etc/apt/apt.conf.d/99stretch && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        curl file bzip2 gzip build-essential gcc g++ python3-pip python3-dev python3-setuptools python3-wheel \
        cython3 libseccomp-dev python2 fp-compiler libxtst6 tini && \
    apt-get install -y -t stretch --no-install-recommends openjdk-8-jdk-headless openjdk-8-jre-headless && \
    mkdir jemalloc && ( \
        cd jemalloc && \
        curl -L "https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2" | \
            tar xvj -C . --strip-components=1 && \
        ./configure && \
        make && make install \
    ) && \
    rm -rf jemalloc && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m judge

ENTRYPOINT ["/usr/bin/tini", "/code/run"]
