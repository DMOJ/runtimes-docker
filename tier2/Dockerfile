FROM dmoj/runtimes-tier1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        jq clang && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/pypy2 && curl -L "$(curl https://api.bitbucket.org/2.0/repositories/squeaky/portable-pypy/downloads | \
            jq -r '[.values[] | select(.name |startswith("pypy-")) | .links.self.href][0]')" | \
        tar xj -C /opt/pypy2 --strip-components=1 && /opt/pypy2/bin/pypy -mcompileall && \
    mkdir /opt/pypy3 && curl -L "$(curl https://api.bitbucket.org/2.0/repositories/squeaky/portable-pypy/downloads | \
            jq -r '[.values[] | select(.name |startswith("pypy3")) | .links.self.href][0]')" | \
        tar xj -C /opt/pypy3 --strip-components=1 && /opt/pypy3/bin/pypy -mcompileall

ENV PATH "/opt/pypy2/bin:/opt/pypy3/bin:${PATH}"
