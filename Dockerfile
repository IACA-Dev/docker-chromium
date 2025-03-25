FROM alpine:3.20

RUN apk --no-cache --update add chromium \
    mesa-egl \
    mesa-gl \
    mesa-dri-gallium \
    vulkan-loader \
    dbus-x11 \
    && adduser -S user \
    && echo "user:user" | chpasswd

USER user

ENTRYPOINT ["chromium"]