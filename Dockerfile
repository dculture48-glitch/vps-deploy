FROM debian
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    openssh-server wget unzip vim curl python3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -O /tmp/ngrok.zip \
    && unzip /tmp/ngrok.zip -d / \
    && chmod +x /ngrok \
    && rm /tmp/ngrok.zip
RUN mkdir -p /run/sshd \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'root:craxid' | chpasswd
COPY openssh.sh /openssh.sh
RUN chmod +x /openssh.sh
EXPOSE 22 4040
CMD ["/openssh.sh"]
