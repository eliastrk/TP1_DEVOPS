FROM debian:trixie-backports

RUN 	apt-get update && \
	apt-get install -y curl && \
	useradd invite

USER invite

ENTRYPOINT ["curl"]
