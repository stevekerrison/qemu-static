# Static QEMU in Docker

For multiarch, it's useful to have a host with binfmt's registered and have containers that can use the apprpriate static qemu build.

Projects such as
[multiarch/qemu-user-static](https://github.com/multiarch/qemu-user-static)
provide this.

The target images provided by multiarch already have the QEMU static binaries
in. But what if you have another project, such as those by
[arm32v7](https://hub.docker.com/r/arm32v7) or [arm64v8](https://hub.docker.com/r/arm64v8), which doesn't contain them?

To avoid external scripts, this container fetches the latest static QEMU from multiarch (just ARM for now), and puts it in an image that you can fetch from in multi-stage build.

Examples:

```
FROM arm32v7/debian:stretch-slim
COPY --from=microsec/qemu-arm-static \
	/usr/bin/qemu-arm-static /usr/bin/qemu-arm-static
# Now do the rest of your stuff, and RUN arm32v7 binaries...
```

```
FROM arm64v8/debian:stretch-slim
COPY --from=microsec/qemu-arm-static \
	/usr/bin/qemu-aarch64-static /usr/bin/qemu-aarch64-static
# Now do the rest of your stuff, and RUN arm64v8 (aarch64) binaries...
```
