# Static QEMU in Docker

For multiarch, it's useful to have a host with binfmt's registered and have containers that can use the apprpriate static qemu build.

Projects such as
[multiarch/qemu-user-static](https://github.com/multiarch/qemu-user-static)
provide this.

The target images provided by multiarch already have the QEMU static binaries
in. But what if you have another project, such as those by
[arm32v7](https://hub.docker.com/r/arm32v7), which doesn't contain them?

To avoid external scripts, this container fetches the latest static QEMU from multiarch (just ARM for now), and puts it in an image that you can fetch from in multi-stage build.

Example:

```
FROM arm32v7/debian:stretch-slim
COPY --from=microsec/qemu-arm-static \
	/usr/bin/qemu-arm-static /usr/bin/qemu-arm-static
# Now do the rest of your stuff, and RUN arm32v7 binaries...

```
