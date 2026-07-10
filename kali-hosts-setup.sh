#!/bin/bash
# kali-hosts-setup.sh
# Run on the Kali Linux attacker VM.
# Adds a /etc/hosts entry so 'dvwa.local' resolves to the
# Ubuntu Server VM's IP address.
#
# Usage:
#   sudo ./kali-hosts-setup.sh <Ubuntu-Server-IP>

set -e

if [ -z "$1" ]; then
  echo "Usage: sudo $0 <Ubuntu-Server-IP>"
  exit 1
fi

UBUNTU_IP="$1"
ENTRY="${UBUNTU_IP} dvwa.local www.dvwa.local"

if grep -q "dvwa.local" /etc/hosts; then
  echo "[i] An entry for dvwa.local already exists in /etc/hosts:"
  grep "dvwa.local" /etc/hosts
  echo "[i] Edit /etc/hosts manually if you need to update the IP."
else
  echo "${ENTRY}" | sudo tee -a /etc/hosts
  echo "[+] Added: ${ENTRY}"
fi

echo "[+] Testing resolution..."
ping -c 2 dvwa.local
