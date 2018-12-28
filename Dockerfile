FROM debian:stretch-slim AS get

LABEL maintainer="Steve Kerrison <steve@usec.io>"
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y curl jq
RUN curl -s \
	https://api.github.com/repos/multiarch/qemu-user-static/releases/latest \
	| jq --raw-output \
	'.assets[] | select(.name=="qemu-arm-static.tar.gz").browser_download_url' \
	| xargs curl -L | tar xzf - -C /usr/bin/
RUN chmod a+x /usr/bin/qemu-arm-static
RUN apt-get clean

FROM scratch
COPY --from=get /usr/bin/qemu-arm-static /usr/bin/qemu-arm-static
