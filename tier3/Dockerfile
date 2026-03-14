FROM dmoj/runtimes-tier2

ARG KOTLIN_ZIP_URL
ARG LEAN4_ZIP_URL

RUN (cd /opt && \
        case "$(arch)" in x86_64) DART_ARCH=x64;; aarch64) DART_ARCH=arm64;; *) false;; esac && \
        curl -L -odart.zip "https://storage.googleapis.com/dart-archive/channels/stable/release/$( \
            curl -sSL https://storage.googleapis.com/dart-archive/channels/stable/release/latest/VERSION | jq -r .version \
        )/sdk/dartsdk-linux-$DART_ARCH-release.zip" && \
        unzip dart.zip && find /opt/dart-sdk -type d -exec chmod go+rx {} + && rm dart.zip) && \
    { curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg; } && \
    { echo 'deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main' > /etc/apt/sources.list.d/nodesource.list; } && \
    apt-get update && \
    apt-get install -y --no-install-recommends unzip libtinfo5 xz-utils libncurses5 \
        gnucobol4 gnat gfortran tcl lua5.3 intercal php-cli gforth swi-prolog pike8.0 sbcl gnustep-devel nodejs algol68g && \
    rm -rf /var/lib/apt/lists/* && \
    curl -L -ogroovy.zip "$(curl -s https://groovy.apache.org/download.html | perl -ne 'if(/(['"'"'"])(https:[^'"'"'"]+-binary-[\d.]+\.zip)\1/){print$2;exit}')" && \
        unzip groovy.zip && \
        mkdir /opt/groovy && \
        mv groovy-*/* /opt/groovy && \
        rm -rf groovy.zip groovy-* && \
    curl -L -okotlin.zip "$KOTLIN_ZIP_URL" && \
        unzip kotlin.zip && mv kotlinc /opt/kotlin && rm kotlin.zip && \
    if [ "$(arch)" = x86_64 ]; then \
        curl -L -otprolog.zip "https://github.com/yingted/OpenTuring/releases/download/v1.0.0-beta/tprolog-v1.0.0-beta.zip" && \
            unzip tprolog.zip && mv tprolog /opt && rm tprolog.zip; fi && \
    mkdir /opt/zig && \
        curl "$(curl -sSL https://ziglang.org/download/index.json | jq -r "to_entries | sort_by(.date) | nth(1) | .value.\"$(arch)-linux\".tarball")" | tar xJ -C /opt/zig --strip-components=1 && \
    if [ "$(arch)" = x86_64 ]; then \
        mkdir /opt/lean && \
        curl -L -olean.zip "$LEAN4_ZIP_URL" && \
        unzip lean.zip && \
        mv lean-*/* /opt/lean && \
        rm -rf lean.zip lean-*; fi && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/tprolog:/opt/groovy/bin:/opt/kotlin/bin:${PATH}:/opt/swift/usr/bin:/opt/zig:/opt/lean/bin"
