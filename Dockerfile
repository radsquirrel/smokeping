FROM alpine:latest
MAINTAINER Brad Bishop <bradleyb@fuzziesquirrel.com>

ENV SMOKEPING_PROBER_VERSION 0.7.0
RUN mkdir /build
RUN apk add --no-cache s6 \
  && wget https://github.com/SuperQ/smokeping_prober/releases/download/v${SMOKEPING_PROBER_VERSION}/smokeping_prober-${SMOKEPING_PROBER_VERSION}.linux-amd64.tar.gz \
  && tar -xzf smokeping_prober-${SMOKEPING_PROBER_VERSION}.linux-amd64.tar.gz \
  && cd smokeping_prober-${SMOKEPING_PROBER_VERSION}.linux-amd64 \
  && mkdir -p /usr/lib/smokeping_prober \
  && install smokeping_prober /usr/lib/smokeping_prober \
  && rm -rf /build
COPY s6 /etc/s6
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["s6-svscan","/etc/s6"]
