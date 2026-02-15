FROM ghcr.io/coolcow/entrypoints:latest

# runtime variables
ENV FDUPES_GIT=https://github.com/adrianlopezroche/fdupes.git \
    ENTRYPOINT_USER=fdupes \
    ENTRYPOINT_GROUP=fdupes \
    ENTRYPOINT_HOME=/data

# install fdupes
RUN apk --no-cache --update add \
      ncurses-libs \
      pcre2 \
  libpcre2-32 \
      sqlite-libs \
    && apk --no-cache --update add --virtual .build-deps \
      alpine-sdk \
      autoconf \
      automake \
      git \
      ncurses-dev \
      pcre2-dev \
      sqlite-dev \
    && git clone ${FDUPES_GIT} /tmp/fdupes \
    && cd /tmp/fdupes \
    && autoreconf --install \
    && ./configure \
    && make \
    && make install \
    && cd \
    && rm -rf /tmp/fdupes \
    && apk --no-cache del .build-deps

WORKDIR $ENTRYPOINT_HOME

ENTRYPOINT ["/entrypoint_su-exec.sh", "fdupes"]
