FROM dmoj/runtimes-tier2

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' > /etc/apt/sources.list.d/dart.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends unzip libtinfo5 xz-utils \
        coffeescript open-cobol gnat gfortran tcl lua5.3 intercal php-cli dart/stable gforth swi-prolog pike8.0 sbcl && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/swift && \
    curl "$(echo -n https://swift.org; curl -s https://swift.org/download/ | grep 'Ubuntu 18.04' | head -n 1 | cut -d'"' -f 2)" | \
        tar xz -C /opt/swift --strip-components=1 && \
    curl -L -ogroovy.zip "$(curl -s http://groovy-lang.org/install.html | perl -ne 'if(/Download zip/){/"(https:.*?\.zip)"/;print$1;exit}')" && \
        unzip groovy.zip && \
        mkdir /opt/groovy && \
        mv groovy-*/* /opt/groovy && \
        rm -rf groovy.zip groovy-* && \
    curl -L -okotlin.zip "$(curl -s https://api.github.com/repos/JetBrains/kotlin/releases | \
            jq -r '[.[] | select(.prerelease | not) | .assets | flatten | .[] | select(.name | startswith("kotlin-compiler")) | .browser_download_url][0]')" && \
        unzip kotlin.zip && mv kotlinc /opt/kotlin && rm kotlin.zip && \
    curl -L -otprolog.zip "https://github.com/yingted/OpenTuring/releases/download/v1.0.0-beta/tprolog-v1.0.0-beta.zip" && \
        unzip tprolog.zip && mv tprolog /opt && rm tprolog.zip && \
    mkdir /opt/zig && \
        curl "https://ziglang.org/download/0.6.0/zig-linux-x86_64-0.6.0.tar.xz" | tar xJ -C /opt/zig  --strip-components=1

ENV PATH "/opt/tprolog:/opt/groovy/bin:/opt/kotlin/bin:${PATH}:/opt/swift/usr/bin:/opt/zig"
