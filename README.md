# ghcr.io/coolcow/fdupes

Simple and minimal Alpine-based Docker image for [fdupes](https://github.com/adrianlopezroche/fdupes).

---

## Overview

fdupes is a command-line program for identifying or deleting duplicate files in specified directories.

---

## Features

- Based on Alpine Linux for a small footprint
- Runs as non-root by default (user: `fdupes`)
- Secure execution via [docker-entrypoints](https://github.com/coolcow/docker-entrypoints)
- Configurable user/group IDs to avoid permission issues on mounted volumes

---

## Usage

### Quick Start

```sh
docker run --rm ghcr.io/coolcow/fdupes
```

Default runtime behavior:

- **ENTRYPOINT:** `/entrypoint_su-exec.sh fdupes`

### Environment Variables

| Variable | Default | Description |
|---|---:|---|
| `PUID` | 1000 | User ID to run fdupes as |
| `PGID` | 1000 | Group ID to run fdupes as |
| `ENTRYPOINT_USER` | fdupes | Internal: user for entrypoint script |
| `ENTRYPOINT_GROUP` | fdupes | Internal: group for entrypoint script |
| `ENTRYPOINT_HOME` | /data | Internal: working directory |

Use `PUID` and `PGID` to run fdupes with your host user's uid/gid and avoid permission issues.

### Find Duplicates Recursively

```sh
docker run -it --rm \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v <PATH_TO_YOUR_DATA>:/data \
  ghcr.io/coolcow/fdupes \
    -r /data
```

Replace `<PATH_TO_YOUR_DATA>` with your data directory.

---

## References

- [fdupes on GitHub](https://github.com/adrianlopezroche/fdupes)
- [fdupes README](http://www.harding.motd.ca/fdupes/README)
- [docker-entrypoints](https://github.com/coolcow/docker-entrypoints)

