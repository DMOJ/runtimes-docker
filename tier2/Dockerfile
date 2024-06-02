FROM dmoj/runtimes-tier1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        jq apt-transport-https dirmngr gnupg ca-certificates xz-utils \
        $([ "$(arch)" = x86_64 ] && echo libc6-dev-i386) \
        openjdk-19-jdk-headless clang llvm ghc golang racket ruby scala nasm chicken-bin && \
    ( export OPAMYES=1 OPAMJOBS=$(($(nproc) + 2)); \
        apt-get install -y --no-install-recommends make m4 patch unzip libgmp-dev && \
        bash -c 'echo | sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh) --no-backup' && \
        runuser -u judge -- opam init --shell-setup --disable-sandboxing --bare && \
        runuser -u judge -- opam switch create dmoj --packages=ocaml.5.0.0,ocaml-option-flambda && \
        runuser -u judge -- opam install base core stdio zarith && \
        runuser -u judge -- opam clean && rm -rf ~judge/.opam/repo \
    ) && \
    if [ "$(arch)" = x86_64 ]; then PYPY_ARCH=linux64; else PYPY_ARCH="$(arch)"; fi && \
    mkdir /opt/pypy2 && curl -L "$(curl https://www.pypy.org/download.html | grep "/pypy2.*$PYPY_ARCH" | head -n1 | cut -d'"' -f4)" | \
        tar xj -C /opt/pypy2 --strip-components=1 && /opt/pypy2/bin/pypy -mcompileall && \
        chmod a+rx /opt/pypy2/lib /opt/pypy2/lib/*.so* && \
    rm -f /opt/pypy2/bin/python* && \
    mkdir /opt/pypy3 && curl -L "$(curl https://www.pypy.org/download.html | grep "/pypy3.*$PYPY_ARCH" | head -n1 | cut -d'"' -f4)" | \
        tar xj -C /opt/pypy3 --strip-components=1 && /opt/pypy3/bin/pypy -mcompileall && \
    rm -f /opt/pypy3/bin/python* && \
    runuser judge -c 'curl https://sh.rustup.rs -sSf | sh -s -- -y' && \
        mkdir rust && ( \
            cd rust && \
            curl -sL https://raw.githubusercontent.com/DMOJ/judge/master/dmoj/executors/RUST.py | \
                sed '/^CARGO_TOML/,/^"""/!d;//d' > Cargo.toml && \
            mkdir src && \
            curl -sL https://raw.githubusercontent.com/DMOJ/judge/master/dmoj/executors/RUST.py | \
                sed '/^TEST_PROGRAM/,/^"""/!d;//d' > src/main.rs && \
            chown -R judge: . && \
            runuser -u judge /home/judge/.cargo/bin/cargo fetch \
        ) && \
        rm -rf rust && \
    if [ "$(arch)" = x86_64 ]; then curl -fsS https://dlang.org/install.sh | bash -s dmd --path /opt/dlang \
        && mv /opt/dlang/dmd-*/* /opt/dlang && rmdir /opt/dlang/dmd-*; fi && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/debian stable-buster main" > \
        /etc/apt/sources.list.d/mono-official-stable.list && \
    curl https://dmoj.ca/dmoj-apt.key | apt-key add - && \
    echo 'deb https://apt.dmoj.ca/ bullseye main' > /etc/apt/sources.list.d/dmoj.list && \
    (echo 'Package: *'; echo 'Pin: origin download.mono-project.com'; echo 'Pin-Priority: 990') > /etc/apt/preferences.d/mono && \
    apt-get update && \
    dpkg-divert --package mono-roslyn --divert /usr/bin/chicken-csc --rename /usr/bin/csc && \
    dpkg-divert --package mono-roslyn --divert /usr/bin/chicken-csi --rename /usr/bin/csi && \
    (cd /tmp && \
        apt download mono-roslyn && \
        dpkg-deb -R mono-roslyn_*.deb roslyn/ && \
        sed -i -e '/^Conflicts: chicken-bin/d' roslyn/DEBIAN/control && \
        dpkg-deb -b roslyn mono-roslyn_no_conflict.deb && \
        rm -rf roslyn/ && \
        apt-get install -y --no-install-recommends mono-devel ./mono-roslyn_no_conflict.deb mono-vbnc fsharp v8dmoj && \
        rm -f *.deb) && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/dlang/linux/bin64:/home/judge/.cargo/bin:/opt/pypy2/bin:/opt/pypy3/bin:/opt/dart-sdk/bin:${PATH}"
