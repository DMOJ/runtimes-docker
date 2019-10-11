FROM dmoj/runtimes-tier2

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' > /etc/apt/sources.list.d/dart.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends libtinfo5 \
        coffeescript open-cobol gnat gfortran tcl lua5.3 intercal php-cli dart/stable gforth swi-prolog pike8.0 && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/swift && \
    curl "$(echo -n https://swift.org; curl -s https://swift.org/download/ | grep 'Ubuntu 18.04' | head -n 1 | cut -d'"' -f 2)" | \
        tar xz -C /opt/swift --strip-components=1

ENV PATH "/opt/swift/usr/bin:${PATH}"
