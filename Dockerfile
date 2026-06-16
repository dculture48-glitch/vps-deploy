FROM debian:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    openssh-server wget curl python3 ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN wget -q https://github.com/ekzhang/bore/releases/download/v0.5.1/bore-v0.5.1-x86_64-unknown-linux-musl.tar.gz -O /tmp/bore.tar.gz \
    && tar -xzf /tmp/bore.tar.gz -C /usr/local/bin/ \
    && chmod +x /usr/local/bin/bore \
    && rm /tmp/bore.tar.gz
RUN mkdir -p /run/sshd \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'root:craxid' | chpasswd
COPY openssh.sh /openssh.sh
RUN chmod +x /openssh.sh
EXPOSE 22
CMD ["/openssh.sh"]
