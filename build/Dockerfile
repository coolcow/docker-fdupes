# Global build arguments
ARG ENTRYPOINTS_VERSION=2.0.0
ARG ALPINE_VERSION=3.23.3
ARG FDUPES_VERSION=v2.4.0

# Stage to fetch scripts from the versioned entrypoints asset image
FROM ghcr.io/coolcow/entrypoints:${ENTRYPOINTS_VERSION} AS entrypoints

# Main build stage
FROM alpine:${ALPINE_VERSION}

ARG FDUPES_VERSION

# Runtime environment variables
ENV ENTRYPOINT_USER=fdupes \
    ENTRYPOINT_GROUP=fdupes \
    ENTRYPOINT_HOME=/data

# install fdupes and required dependencies
RUN apk --no-cache --update add \
      ncurses-libs \
      pcre2 \
      libpcre2-32 \
      shadow \
      sqlite-libs \
      su-exec \
    && apk --no-cache --update add --virtual .build-deps \
      alpine-sdk \
      autoconf \
      automake \
      git \
      ncurses-dev \
      pcre2-dev \
      sqlite-dev \
    && git clone --branch ${FDUPES_VERSION} --depth 1 https://github.com/adrianlopezroche/fdupes.git /tmp/fdupes \
    && cd /tmp/fdupes \
    && autoreconf --install \
    && ./configure \
    && make \
    && make install \
    && cd \
    && rm -rf /tmp/fdupes \
    && apk --no-cache del .build-deps

# Copy required scripts from the entrypoints asset image
COPY --from=entrypoints /assets/create_user_group_home.sh /usr/local/bin/
COPY --from=entrypoints /assets/entrypoint_su-exec.sh /usr/local/bin/

# Make scripts executable
RUN chmod +x /usr/local/bin/*.sh

WORKDIR $ENTRYPOINT_HOME

ENTRYPOINT ["/usr/local/bin/entrypoint_su-exec.sh", "fdupes"]
CMD ["--help"]

ARG LABEL_VERSION="latest"
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF
ARG LABEL_LICENSE="GPL-3.0"
ARG LABEL_IMAGE_NAME="ghcr.io/coolcow/fdupes"
ARG LABEL_DESCRIPTION="Minimal Alpine-based fdupes Docker image."
ARG LABEL_URL="https://ghcr.io/coolcow/fdupes"
ARG LABEL_VCS_URL="https://github.com/coolcow/docker-fdupes"
ARG LABEL_MAINTAINER="Jean-Michel Ruiz (coolcow) <mail@coolcow.org>"

# OCI / OpenContainer image labels
LABEL org.opencontainers.image.title=$LABEL_IMAGE_NAME \
      org.opencontainers.image.description=$LABEL_DESCRIPTION \
      org.opencontainers.image.version=$LABEL_VERSION \
      org.opencontainers.image.created=$LABEL_BUILD_DATE \
      org.opencontainers.image.revision=$LABEL_VCS_REF \
      org.opencontainers.image.authors=$LABEL_MAINTAINER \
      org.opencontainers.image.licenses=$LABEL_LICENSE \
      org.opencontainers.image.source=$LABEL_VCS_URL \
      org.opencontainers.image.url=$LABEL_URL

VOLUME $ENTRYPOINT_HOME
