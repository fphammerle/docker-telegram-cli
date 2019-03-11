FROM ubuntu:18.04

# https://github.com/vysheng/tg/blob/master/README.md#linux-and-bsds
RUN apt-get update && apt-get install --yes --no-install-recommends \
    `# from readme` \
    libconfig-dev \
    libevent-dev \
    libjansson-dev \
    liblua5.2-dev \
    libpython-dev \
    libreadline-dev \
    `#libssl-dev` \
    lua5.2 \
    make \
    `# from failing configure` \
    gcc \
    zlib1g-dev \
    `# from failing build` \
    libssl1.0-dev

RUN adduser --system builder
USER builder
COPY --chown=builder:nogroup ./tg /tg
WORKDIR /tg
RUN ./configure
RUN make

RUN mkdir ~/.telegram-cli
VOLUME ~/.telegram-cli
CMD ["/tg/bin/telegram-cli"]
