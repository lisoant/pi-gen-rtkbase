#!/bin/bash

BOOT_MOUNT="/boot/firmware"
TARGET="/etc/wpa_supplicant/wpa_supplicant.conf"

if [ -f "$BOOT_MOUNT/wpa_supplicant.conf" ]; then
    cp "$BOOT_MOUNT/wpa_supplicant.conf" "$TARGET"
    chmod 600 "$TARGET"
    chown root:root "$TARGET"
    echo "WiFi config copied from /boot to /etc/wpa_supplicant"
    rm "$BOOT_MOUNT/wpa_supplicant.conf"
fi
