FROM debian:stretch-slim

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
CMD ["echo", \
	"qemu-arm-static acquired, maybe you want to use me in multistage build?"]    
