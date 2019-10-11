FROM dmoj/runtimes-tier2

RUN curl https://dmoj.ca/dmoj-apt.key | apt-key add - && \
    echo 'deb [arch=amd64] https://apt.dmoj.ca/ stretch main non-free' > /etc/apt/sources.list.d/dmoj.list && \
    curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' > /etc/apt/sources.list.d/dart.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        coffeescript open-cobol gnat gfortran tcl lua5.3 intercal php-cli v8dmoj dart/stable && \
    rm -rf /var/lib/apt/lists/*
