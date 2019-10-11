FROM debian:buster

RUN echo deb http://deb.debian.org/debian/ stretch main > /etc/apt/sources.list.d/stretch.list && \
    echo 'APT::Default-Release "buster";' > /etc/apt/apt.conf.d/99stretch && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        curl file gcc g++ python3-pip python3-dev python3-setuptools python3-wheel cython3 libseccomp-dev bzip2 gzip \
        python2 openjdk-11-jdk-headless fp-compiler && \
    apt-get install -y -t stretch --no-install-recommends openjdk-8-jdk-headless && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/code/run"]
