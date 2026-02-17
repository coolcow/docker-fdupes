#!/bin/sh

set -e

export TARGET_UID=${FDUPES_UID:-1000}
export TARGET_GID=${FDUPES_GID:-1000}
export TARGET_REMAP_IDS=${FDUPES_REMAP_IDS:-1}
export TARGET_USER=${FDUPES_USER:-fdupes}
export TARGET_GROUP=${FDUPES_GROUP:-fdupes}
export TARGET_HOME=${FDUPES_HOME:-/home/fdupes}
export TARGET_SHELL=${FDUPES_SHELL:-/bin/sh}

exec /usr/local/bin/entrypoint_su-exec.sh fdupes "$@"
