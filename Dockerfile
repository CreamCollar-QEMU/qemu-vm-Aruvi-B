FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  qemu qemu-utils qemu-system-x86 \
  xfce4 tightvncserver novnc websockify \
  git curl wget locales && \
  locale-gen en_IN.UTF-8

ENV LANG=en_IN.UTF-8
WORKDIR /opt
RUN git clone https://github.com/novnc/noVNC.git && \
    git clone https://github.com/novnc/websockify.git noVNC/utils/websockify

RUN mkdir -p /root/.vnc && \
    echo "vncpass" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

WORKDIR /os-exploration
VOLUME ["/os-images"]

EXPOSE 5901 6080

CMD bash -c "\
  export DISPLAY=:1 && \
  vncserver :1 -geometry 1280x800 -depth 24 && \
  /opt/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080"
