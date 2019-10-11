FROM dmoj/runtimes-tier1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        jq wget apt-transport-https dirmngr gnupg ca-certificates clang ocaml ghc racket && \
    mkdir /opt/pypy2 && curl -L "$(curl https://api.bitbucket.org/2.0/repositories/squeaky/portable-pypy/downloads | \
            jq -r '[.values[] | select(.name |startswith("pypy-")) | .links.self.href][0]')" | \
        tar xj -C /opt/pypy2 --strip-components=1 && /opt/pypy2/bin/pypy -mcompileall && \
    mkdir /opt/pypy3 && curl -L "$(curl https://api.bitbucket.org/2.0/repositories/squeaky/portable-pypy/downloads | \
            jq -r '[.values[] | select(.name |startswith("pypy3")) | .links.self.href][0]')" | \
        tar xj -C /opt/pypy3 --strip-components=1 && /opt/pypy3/bin/pypy -mcompileall && \
    mkdir /opt/rust && curl https://sh.rustup.rs -sSf | CARGO_HOME=/opt/rust RUSTUP_HOME=/opt/rust sh -s -- -y && \
    wget http://downloads.lightbend.com/scala/2.12.4/scala-2.12.4.deb && dpkg -i scala-2.12.4.deb && \
    wget http://downloads.dlang.org/releases/2.x/2.071.1/dmd_2.071.1-0_amd64.deb && dpkg -i dmd_2.071.1-0_amd64.deb && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/debian stable-buster main" > \
        /etc/apt/sources.list.d/mono-official-stable.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends mono-devel mono-vbnc && \
    rm -rf /var/lib/apt/lists/*

ENV PATH "/opt/rust/bin:/opt/pypy2/bin:/opt/pypy3/bin:${PATH}"
