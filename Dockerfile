FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV USER=appuser
ENV PASS=render123

RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    dbus-x11 x11-xserver-utils xvfb x11vnc \
    novnc websockify sudo supervisor \
    net-tools curl wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ${USER} && \
    echo "${USER}:${PASS}" | chpasswd && \
    adduser ${USER} sudo

RUN mkdir -p /var/run/dbus /var/log/supervisor && \
    echo "startxfce4" > /home/${USER}/.xsession && \
    chown ${USER}:${USER} /home/${USER}/.xsession

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh

RUN chmod +x /start.sh

ENV PORT=10000
EXPOSE 10000

CMD ["/start.sh"]
