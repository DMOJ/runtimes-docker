FROM dmoj/runtimes-tier1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        jq apt-transport-https dirmngr gnupg ca-certificates \
        openjdk-11-jdk-headless clang ghc golang racket ruby scala nasm libc6-dev-i386 && \
    ( \
        apt-get install -y --no-install-recommends make m4 patch unzip libgmp-dev && \
        bash -c 'echo | sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh) --no-backup' && \
        runuser -u judge -- opam init --shell-setup --disable-sandboxing && \
        runuser -u judge -- opam install -y base core stdio zarith && \
        runuser -u judge -- opam clean && rm -rf ~judge/.opam/repo \
    ) && \
    mkdir /opt/pypy2 && curl -L "$(curl https://api.bitbucket.org/2.0/repositories/squeaky/portable-pypy/downloads | \
            jq -r '[.values[] | select(.name |startswith("pypy-")) | .links.self.href][0]')" | \
        tar xj -C /opt/pypy2 --strip-components=1 && /opt/pypy2/bin/pypy -mcompileall && \
    mkdir /opt/pypy3 && curl -L "$(curl https://api.bitbucket.org/2.0/repositories/squeaky/portable-pypy/downloads | \
            jq -r '[.values[] | select(.name |startswith("pypy3")) | .links.self.href][0]')" | \
        tar xj -C /opt/pypy3 --strip-components=1 && /opt/pypy3/bin/pypy -mcompileall && \
    runuser judge -c 'curl https://sh.rustup.rs -sSf | sh -s -- -y' && \
        mkdir rust && ( \
            cd rust && \
            curl -sL https://raw.githubusercontent.com/DMOJ/judge/master/dmoj/executors/RUST.py | \
                sed '/^CARGO_TOML/,/^'"'''"'/!d;//d' > Cargo.toml && \
            curl -sL https://raw.githubusercontent.com/DMOJ/judge/master/dmoj/executors/RUST.py | \
                sed '/^CARGO_LOCK/,/^'"'''"'/!d;//d' > Cargo.lock && \
            mkdir src && \
            curl -sL https://raw.githubusercontent.com/DMOJ/judge/master/dmoj/executors/RUST.py | \
                sed '/^HELLO_WORLD_PROGRAM/,/^'"'''"'/!d;//d' > src/main.rs && \
            chown -R judge: . && \
            runuser -u judge /home/judge/.cargo/bin/cargo fetch \
        ) && \
        rm -rf rust && \
    curl -L -odmd.deb "$(curl -s https://dlang.org/download.html | perl -ne 'if(/"([^"~]*_amd64.deb)/){print $1;exit}')" && \
        apt install ./dmd.deb && rm dmd.deb && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/debian stable-buster main" > \
        /etc/apt/sources.list.d/mono-official-stable.list && \
    curl https://dmoj.ca/dmoj-apt.key | apt-key add - && \
    echo 'deb [arch=amd64] https://apt.dmoj.ca/ stretch main non-free' > /etc/apt/sources.list.d/dmoj.list && \
    (echo 'Package: *'; echo 'Pin: origin download.mono-project.com'; echo 'Pin-Priority: 990') > /etc/apt/preferences.d/mono && \
    apt-get update && \
    (cd /tmp && \
        apt download mono-roslyn && \
        dpkg-deb -R mono-roslyn_*.deb roslyn/ && \
        sed -i -e '/^Conflicts: chicken-bin/d' roslyn/DEBIAN/control && \
        dpkg-deb -b roslyn mono-roslyn_no_conflict.deb && \
        apt-get install -y --no-install-recommends mono-devel && \
        dpkg -i mono-roslyn_no_conflict.deb) && \
    apt-get install -y --no-install-recommends mono-vbnc fsharp v8dmoj && \
    dpkg-divert --package mono-roslyn --divert /usr/bin/chicken-csc --rename /usr/bin/csc && \
    dpkg-divert --package mono-roslyn --divert /usr/bin/chicken-csi --rename /usr/bin/csi && \
    apt-get install -y --no-install-recommends chicken-bin && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/home/judge/.cargo/bin:/opt/pypy2/bin:/opt/pypy3/bin:${PATH}" DMOJ_CARGO_OFFLINE="1"
