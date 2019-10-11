FROM dmoj/runtimes-tier2

RUN curl https://dmoj.ca/dmoj-apt.key | apt-key add - && \
    echo 'deb [arch=amd64] https://apt.dmoj.ca/ stretch main non-free' > /etc/apt/sources.list.d/dmoj.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        coffeescript open-cobol gnat gfortran tcl lua5.3 intercal php-cli v8dmoj && \
    rm -rf /var/lib/apt/lists/*
