# ghcr.io/coolcow/fdupes

A minimal Alpine-based Docker image for [fdupes](https://github.com/adrianlopezroche/fdupes).

The image runs as non-root via `su-exec` entrypoint scripts from [docker-entrypoints](https://github.com/coolcow/docker-entrypoints) and can be tuned with build-time version arguments.

---

## Usage

### Quick Start

```sh
docker run --rm ghcr.io/coolcow/fdupes --help
```

### Find Duplicates Recursively

```sh
docker run -it --rm \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v /path/to/data:/data \
  ghcr.io/coolcow/fdupes \
  -r /data
```

### Runtime Environment Variables

| Variable | Default | Description |
| --- | --- | --- |
| `PUID` | `1000` | User ID to run the process as. |
| `PGID` | `1000` | Group ID to run the process as. |
| `ENTRYPOINT_USER` | `fdupes` | Internal user used by entrypoint scripts. |
| `ENTRYPOINT_GROUP` | `fdupes` | Internal group used by entrypoint scripts. |
| `ENTRYPOINT_HOME` | `/data` | Working directory in the container. |

---

## Configuration

### Build-Time Arguments

Customize the image at build time with `docker build --build-arg <KEY>=<VALUE>`.

| Argument | Default | Description |
| --- | --- | --- |
| `ALPINE_VERSION` | `3.23.3` | Version of the Alpine base image. |
| `ENTRYPOINTS_VERSION` | `2.0.0` | Version of the `coolcow/entrypoints` image used for scripts. |
| `FDUPES_VERSION` | `v2.3.2` | Git tag/branch of `adrianlopezroche/fdupes` to build. |

---

## Local Testing

Run the built-in smoke tests locally.

1. `docker build -t ghcr.io/coolcow/fdupes:local-test-build -f build/Dockerfile build`
2. `docker build --build-arg APP_IMAGE=ghcr.io/coolcow/fdupes:local-test-build -f build/Dockerfile.test build`

---

## References

- [fdupes on GitHub](https://github.com/adrianlopezroche/fdupes)
- [fdupes README](http://www.harding.motd.ca/fdupes/README)
- [docker-entrypoints](https://github.com/coolcow/docker-entrypoints)

---

## License

GPL-3.0. See [LICENSE.txt](LICENSE.txt) for details.

