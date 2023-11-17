FROM ubuntu:22.04

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0755 entrypoint.sh

RUN apt update -y && apt install -y lftp

ENTRYPOINT ["/entrypoint.sh"]
