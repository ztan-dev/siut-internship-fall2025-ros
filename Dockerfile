# Reference: https://github.com/GrijzePanda/ros2-gazebo-vnc

# Base image
FROM osrf/ros:jazzy-desktop

LABEL name="ros2-gazebo-vnc" \
      description="ROS 2 Jazzy + Gazebo Harmonic + noVNC desktop"

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    USERNAME=ubuntu \
    HOME=/home/ubuntu \
    DISPLAY=:1 \
    DISPLAY_WIDTH=1600 \
    DISPLAY_HEIGHT=900 \
    SVGA_VGPU10=0 \
    ROS_LOG_DIR=/tmp/.ros/log \
    VNC_PASSWORD=honor-freethinking-humanism

# Start script setup
COPY start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR $HOME

# Locale, essentials, GUI packages, OpenGL
RUN apt update && apt install -y \
    sudo wget curl gnupg2 lsb-release software-properties-common \
    locales xfce4 xfce4-terminal x11-apps micro \
    mesa-utils libgl1-mesa-dri libglx-mesa0 libglu1-mesa libegl-mesa0 \
    ca-certificates && \
    locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    add-apt-repository universe

# Install Gazebo
RUN curl -fsSL https://packages.osrfoundation.org/gazebo.gpg -o /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] \
    https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/gazebo-stable.list && \
    apt update && apt install -y \
    gz-harmonic libgz-transport14-dev ros-jazzy-ros-gz ros-jazzy-urdf-tutorial ros-jazzy-rqt-tf-tree ros-jazzy-backward-ros

# Install X11, VNC server, noVNC, and other tools
RUN apt-get update && apt-get install -y \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    xterm \
    vim \
    btop \
    dbus-x11 \
    net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Final APT check
RUN apt update && apt full-upgrade -y && rm -rf /var/lib/apt/lists/*

# Switch user & permissions
RUN mkdir -p $HOME && chown -R $USERNAME:$USERNAME $HOME
USER $USERNAME

# VNC setup
RUN mkdir -p ~/.vnc && x11vnc -storepasswd honor-freethinking-humanism ~/.vnc/passwd

RUN echo -e "#!/bin/bash\nxrdb \$HOME/.Xresources\nstartxfce4 &" > $HOME/.vnc/xstartup && \
    chmod +x $HOME/.vnc/xstartup

# Expose VNC port
EXPOSE 6080

# ROS 2 entrypoint
RUN echo "source /opt/ros/jazzy/setup.bash" >> $HOME/.bashrc

CMD ["/start.sh"]
