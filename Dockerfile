FROM ubuntu:24.04
# FROM osrf/ros:jazzy-desktop

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

# # Install necessary tools for Gazebo Harmonic installation
# # ref: https://gazebosim.org/docsp/harmonic/install_ubuntu/
# RUN apt-get update && apt-get install -y \
#     curl \ 
#     lsb-release \
#     gnupg \
#     && rm -rf /var/lib/apt/lists/* \
#     && sudo curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg \
#     && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null \
#     && rm -rf /var/lib/apt/lists/* 

# # Install Gazebo Harmonic
# RUN apt-get update && apt-get install -y \
#     && apt-get install -y gz-harmonic \
#     && rm -rf /var/lib/apt/lists/*

# # Install additional ROS 2 packages for navigation and simulation
# RUN apt-get update && apt-get install -y \
#     ros-jazzy-navigation2 \
#     ros-jazzy-nav2-bringup \
#     ros-jazzy-ros-gz \
#     ros-jazzy-rviz2 \
#     && rm -rf /var/lib/apt/lists/*

# # Create workspace directory
# RUN mkdir -p /workspace
# WORKDIR /workspace

# Set up VNC password (optional, but recommended)
RUN mkdir -p ~/.vnc && x11vnc -storepasswd honor-freethinking-humanism ~/.vnc/passwd

# Expose noVNC port
EXPOSE 6080

# Start script
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
