FROM dmoj/runtimes-tier2

RUN (cd /opt && \
        case "$(arch)" in x86_64) DART_ARCH=x64;; aarch64) DART_ARCH=arm64;; *) false;; esac && \
        curl -L -odart.zip "https://storage.googleapis.com/dart-archive/channels/stable/release/$( \
            curl -sSL https://storage.googleapis.com/dart-archive/channels/stable/release/latest/VERSION | jq -r .version \
        )/sdk/dartsdk-linux-$DART_ARCH-release.zip" && \
        unzip dart.zip && find /opt/dart-sdk -type d -exec chmod go+rx {} + && rm dart.zip) && \
    apt-get update && \
    apt-get install -y --no-install-recommends unzip libtinfo5 xz-utils \
        coffeescript gnucobol4 gnat gfortran tcl lua5.3 intercal php-cli gforth swi-prolog pike8.0 sbcl && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/swift && \
    if [ "$(arch)" = x86_64 ]; then \
        curl --compressed -L "$(curl --compressed -sL https://swift.org/download/ | grep 'Ubuntu 18.04' | grep 5.4 | head -n 1 | cut -d'"' -f 2)" | \
            tar xz -C /opt/swift --strip-components=1; fi && \
    curl -L -ogroovy.zip "$(curl -s https://groovy.apache.org/download.html | perl -ne 'if(/(['"'"'"])(https:[^'"'"'"]+-binary-[\d.]+\.zip)\1/){print$2;exit}')" && \
        unzip groovy.zip && \
        mkdir /opt/groovy && \
        mv groovy-*/* /opt/groovy && \
        rm -rf groovy.zip groovy-* && \
    curl -L -okotlin.zip "$(curl -s https://api.github.com/repos/JetBrains/kotlin/releases | \
            jq -r '[.[] | select(.prerelease | not) | .assets | flatten | .[] | select(.name | startswith("kotlin-compiler")) | .browser_download_url][0]')" && \
        unzip kotlin.zip && mv kotlinc /opt/kotlin && rm kotlin.zip && \
    if [ "$(arch)" = x86_64 ]; then \
        curl -L -otprolog.zip "https://github.com/yingted/OpenTuring/releases/download/v1.0.0-beta/tprolog-v1.0.0-beta.zip" && \
            unzip tprolog.zip && mv tprolog /opt && rm tprolog.zip; fi && \
    mkdir /opt/zig && \
        curl "https://ziglang.org/download/0.6.0/zig-linux-$(arch)-0.6.0.tar.xz" | tar xJ -C /opt/zig --strip-components=1 && \
    if [ "$(arch)" = x86_64 ]; then \
        mkdir /opt/lean && \
        curl --compressed -L "https://github.com/leanprover/lean4/releases/download/v4.0.0-m2/lean-4.0.0-m2-linux.tar.gz" | \
        tar xz -C /opt/lean --strip-components=1; fi

ENV PATH "/opt/tprolog:/opt/groovy/bin:/opt/kotlin/bin:/opt/dart-sdk/bin:${PATH}:/opt/swift/usr/bin:/opt/zig:/opt/lean/bin"
