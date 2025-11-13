#!/bin/bash
set -e

# Start Xvfb
Xvfb :99 -screen 0 1280x720x16 &
XVFB_PID=$!
export DISPLAY=:99

# Wait for X server
sleep 2

# Start xfce4 desktop
dbus-launch startxfce4 &

# Wait for desktop to initialize
sleep 3

# Start VNC server
x11vnc -display :99 -forever -shared -rfbauth ~/.vnc/passwd -rfbport 5900 &
VNC_PID=$!

# Wait for VNC to be ready
sleep 2

# Start noVNC
websockify --web=/usr/share/novnc/ 6080 localhost:5900

# Keep container running
wait
