FROM dmoj/runtimes-tier1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        jq apt-transport-https dirmngr gnupg ca-certificates clang ocaml ghc golang racket ruby scala nasm && \
    mkdir /opt/pypy2 && curl -L "$(curl https://api.bitbucket.org/2.0/repositories/squeaky/portable-pypy/downloads | \
            jq -r '[.values[] | select(.name |startswith("pypy-")) | .links.self.href][0]')" | \
        tar xj -C /opt/pypy2 --strip-components=1 && /opt/pypy2/bin/pypy -mcompileall && \
    mkdir /opt/pypy3 && curl -L "$(curl https://api.bitbucket.org/2.0/repositories/squeaky/portable-pypy/downloads | \
            jq -r '[.values[] | select(.name |startswith("pypy3")) | .links.self.href][0]')" | \
        tar xj -C /opt/pypy3 --strip-components=1 && /opt/pypy3/bin/pypy -mcompileall && \
    mkdir /opt/rust && curl https://sh.rustup.rs -sSf | CARGO_HOME=/opt/rust RUSTUP_HOME=/opt/rust sh -s -- -y && \
        /opt/rust/bin/rustup toolchain install stable && \
    curl -L -odmd.deb "$(curl -s https://dlang.org/download.html | perl -ne 'if(/"([^"~]*_amd64.deb)/){print $1;exit}')" && \
        apt install ./dmd.deb && rm dmd.deb && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/debian stable-buster main" > \
        /etc/apt/sources.list.d/mono-official-stable.list && \
    curl https://dmoj.ca/dmoj-apt.key | apt-key add - && \
    echo 'deb [arch=amd64] https://apt.dmoj.ca/ stretch main non-free' > /etc/apt/sources.list.d/dmoj.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends mono-devel mono-vbnc fsharp v8dmoj && \
    dpkg-divert --package mono-roslyn --divert /usr/bin/chicken-csc --rename /usr/bin/csc && \
    dpkg-divert --package mono-roslyn --divert /usr/bin/chicken-csi --rename /usr/bin/csi && \
    apt-get install -y --no-install-recommends chicken-bin && \
    rm -rf /var/lib/apt/lists/*

ENV PATH "/opt/rust/bin:/opt/pypy2/bin:/opt/pypy3/bin:${PATH}"
