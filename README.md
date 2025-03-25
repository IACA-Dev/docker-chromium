<h1 align="center">Docker X11 Firefox Kiosk</h1>
<p align="center">Powered by </p>
<p align="center">
<a href="https://iaca-electronique.com">
<img alt="IACA Logo" style="" width="250px" src="https://www.iaca-electronique.com/img/logo.png">
</a>
</p>

___

## 📄 Purpose

This repository contains Docker configuration to build X11/Wayland Chromium image.

## Table of Contents

- [🛠️ Build](#-build)
- [▶️ Run](#-run)
- [🧑‍🤝‍🧑 Contributors](#-contributors)

___

## Requirement

* Docker
* Docker compose (optional)
* Git
* X11 or Wayland running environment

## 🛠️ Build

```bash
# Import
git clone https://github.com/IACA-Dev/docker-chromium.git
cd docker-chromium

# Build
docker build -t docker-chromium .
```

## ▶️ Run

### 1. Run container

#### From Docker Hub (easy way, no build required) :

##### X11

```bash
docker run \
  --rm -i \
  -v <xauthority-dir>:/mnt/xauthority.d \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e XAUTHORITY=/mnt/xauthority.d/Xauthority \
  -e DISPLAY=$DISPLAY \
  --net=host \
  iacaelectronique/chromium <target-url>
```

##### Wayland

```bash
docker run \
        -e XDG_RUNTIME_DIR=<run-dir> \
        -e WAYLAND_DISPLAY=wayland-0 \
        -v <run-dir>:<run-dir> \
        -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
        -u "0:0" \
        --privileged \
        iacaelectronique/chromium --no-sandbox \
                --ozone-platform=wayland \
                --chrome-frame --kiosk <url>
```

1. **Wayland Environment Variables**:
    - `XDG_RUNTIME_DIR`: Directory for Wayland runtime data (in example it's `<run-dir>` for the current user).
    - `WAYLAND_DISPLAY`: Name of the Wayland display socket (`wayland-0` is common).

2. **Volume Mapping**:
    - `<run-dir>:<run-dir>`: Maps the Wayland runtime directory into the container.
    - `/var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket`: Connects the container to the system D-Bus socket, allowing for system-level communication like device or service event handling.

3. **User Adjustments**:
    - `-u "0:0"`: Ensures that the container runs with elevated privileges.

4. **Privileged Mode**:
    - `--privileged`: Required for kiosk setups to enable features like input and device handling.

5. **Browser Flags**:
    - `--no-sandbox`: Disables the browser's sandbox security. Use only if absolutely necessary.
    - `--ozone-platform=wayland`: Explicitly specifies Wayland as the graphics platform.
    - `--chrome-frame`: Enables a borderless, frameless browser window.
    - `--kiosk <target-url>`: Launches the browser in kiosk mode, displaying the specified URL.

### Examples

```bash
xhost + local:docker

docker run \
  --rm -i \
  -v /home/pi:/mnt/xauthority.d \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e XAUTHORITY=/mnt/xauthority.d/Xauthority \
  -e DISPLAY=$DISPLAY \
  --net=host \
  iacaelectronique/x11-chromium www.google.com
```


## 🧑‍🤝‍🧑 Contributors

* Julien FAURE [✉️ julien.faure@iaca-electronique.com](mailto:julien.faure@iaca-electronique.com) (*IACA Electronique*)