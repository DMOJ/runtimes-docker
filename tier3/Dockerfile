FROM dmoj/runtimes-tier2

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' > /etc/apt/sources.list.d/dart.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends unzip libtinfo5 \
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
        unzip kotlin.zip && mv kotlinc /opt/kotlin && rm kotlin.zip

ENV PATH "/opt/swift/usr/bin:/opt/groovy/bin:/opt/kotlin/bin:${PATH}"
