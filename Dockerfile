FROM ubuntu:22.04

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0755 entrypoint.sh

RUN apt update -y && apt install openssh-client -y && apt clean all

ENTRYPOINT ["/entrypoint.sh"]
