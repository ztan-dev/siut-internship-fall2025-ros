# FROM ubuntu:24.04
FROM osrf/ros:jazzy-desktop

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install X11, VNC server, noVNC, and a simple GUI app for testing
RUN apt-get update && apt-get install -y \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    xterm \
    xfce4 \
    xfce4-goodies \
    dbus-x11 \
    net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up VNC password (optional, but recommended)
RUN mkdir -p ~/.vnc && x11vnc -storepasswd honor-freethinking-humanism ~/.vnc/passwd

# Expose noVNC port
EXPOSE 6080

# Start script
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
