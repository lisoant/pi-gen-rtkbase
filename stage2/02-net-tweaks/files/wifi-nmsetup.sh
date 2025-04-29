#!/bin/bash

BOOT_MOUNT="/boot/firmware"
TARGET_DIR="/etc/NetworkManager/system-connections"

if [ ! -f "${BOOT_MOUNT}/wpa_supplicant.conf" ]; then
    echo "No wpa_supplicant.conf found, exiting."
    exit 0
fi

# Parse SSID and PSK
SSID=$(awk -F '"' '/ssid/ {print $2}' "${BOOT_MOUNT}/wpa_supplicant.conf" | head -n1)
PSK=$(awk -F '"' '/psk/ {print $2}' "${BOOT_MOUNT}/wpa_supplicant.conf" | head -n1)

if [ -z "$SSID" ] || [ -z "$PSK" ]; then
    echo "SSID or PSK not found in wpa_supplicant.conf, exiting."
    exit 1
fi

# Create NetworkManager connection file
CONNECTION_FILE="${TARGET_DIR}/${SSID}.nmconnection"

mkdir -p "${TARGET_DIR}"

cat <<EOF > "${CONNECTION_FILE}"
[connection]
id=${SSID}
type=wifi
autoconnect=true

[wifi]
mode=infrastructure
ssid=${SSID}

[wifi-security]
auth-alg=open
key-mgmt=wpa-psk
psk=${PSK}

[ipv4]
method=auto

[ipv6]
method=auto
EOF

chmod 600 "${CONNECTION_FILE}"
chown root:root "${CONNECTION_FILE}"

echo "NetworkManager connection created for SSID: ${SSID}"

# Optional: remove wpa_supplicant.conf after import
rm -f "${BOOT_MOUNT}/wpa_supplicant.conf"
