FROM debian:buster

RUN echo deb http://deb.debian.org/debian/ stretch main > /etc/apt/sources.list.d/stretch.list && \
    echo 'APT::Default-Release "buster";' > /etc/apt/apt.conf.d/99stretch && \
    apt-get update && \
    apt-get install -y curl jq python3-pip python3-dev cython3 libseccomp-dev \
        python2 openjdk-11-jdk-headless clang fp-compiler && \
    apt-get install -y -t stretch openjdk-8-jdk-headless && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/pypy2 && curl -L "$(curl https://api.bitbucket.org/2.0/repositories/squeaky/portable-pypy/downloads | \
            jq -r '[.values[] | select(.name |startswith("pypy-")) | .links.self.href][0]')" | \
        tar xj -C /opt/pypy2 --strip-components=1 && /opt/pypy2/bin/pypy -mcompileall && \
    mkdir /opt/pypy3 && curl -L "$(curl https://api.bitbucket.org/2.0/repositories/squeaky/portable-pypy/downloads | \
            jq -r '[.values[] | select(.name |startswith("pypy3")) | .links.self.href][0]')" | \
        tar xj -C /opt/pypy3 --strip-components=1 && /opt/pypy3/bin/pypy -mcompileall

ENV PATH "/opt/pypy2/bin:/opt/pypy3/bin:${PATH}"

ENTRYPOINT ["/code/run"]
