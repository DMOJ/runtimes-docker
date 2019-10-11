FROM dmoj/runtimes-tier2

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' > /etc/apt/sources.list.d/dart.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        coffeescript open-cobol gnat gfortran tcl lua5.3 intercal php-cli dart/stable gforth swi-prolog pike8.0 && \
    rm -rf /var/lib/apt/lists/*
