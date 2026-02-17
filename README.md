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
  -e FDUPES_UID=$(id -u) \
  -e FDUPES_GID=$(id -g) \
  -v /path/to/fdupes-home:/home/fdupes \
  -v /path/to/data:/data \
  ghcr.io/coolcow/fdupes \
  -r /data
```

### Runtime Environment Variables

| Variable | Default | Target | Description |
| --- | --- | --- | --- |
| `FDUPES_UID` | `1000` | `TARGET_UID` | User ID to run `fdupes` as. |
| `FDUPES_GID` | `1000` | `TARGET_GID` | Group ID to run `fdupes` as. |
| `FDUPES_REMAP_IDS` | `1` | `TARGET_REMAP_IDS` | Set `0` to disable remapping conflicting UID/GID entries. |
| `FDUPES_USER` | `fdupes` | `TARGET_USER` | Runtime user name inside the container. |
| `FDUPES_GROUP` | `fdupes` | `TARGET_GROUP` | Runtime group name inside the container. |
| `FDUPES_HOME` | `/home/fdupes` | `TARGET_HOME` | Home directory used by `fdupes` and as default workdir. |
| `FDUPES_SHELL` | `/bin/sh` | `TARGET_SHELL` | Login shell for the runtime user. |

`Target` shows the corresponding variable used by `coolcow/entrypoints`.

---

## Configuration

### Build-Time Arguments

Customize the image at build time with `docker build --build-arg <KEY>=<VALUE>`.

| Argument | Default | Description |
| --- | --- | --- |
| `ALPINE_VERSION` | `3.23.3` | Version of the Alpine base image. |
| `ENTRYPOINTS_VERSION` | `2.2.0` | Version of the `coolcow/entrypoints` image used for scripts. |
| `FDUPES_VERSION` | `v2.4.0` | Git tag/branch of `adrianlopezroche/fdupes` to build. |

---

## Migration Notes

Runtime user/group environment variables were renamed to image-specific `FDUPES_*` names.

- `PUID` → `FDUPES_UID`
- `PGID` → `FDUPES_GID`
- `ENTRYPOINT_USER` → `FDUPES_USER`
- `ENTRYPOINT_GROUP` → `FDUPES_GROUP`
- `ENTRYPOINT_HOME` → `FDUPES_HOME`

Update your `docker run` / `docker-compose` environment configuration accordingly when upgrading from older tags.

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

