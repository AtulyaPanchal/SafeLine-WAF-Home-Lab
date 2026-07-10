#!/bin/bash
# 04-safeline-install.sh
# Run on the Ubuntu Server VM.
# Installs SafeLine WAF via its official installer script
# (installs Docker/Docker Compose automatically if missing).

set -e

echo "[+] Checking internet connectivity..."
ping -c 2 google.com || { echo "No internet access — check network before continuing."; exit 1; }

echo "[+] Running SafeLine WAF installer..."
bash -c "$(curl -fsSLk https://waf.chaitin.com/release/latest/manager.sh)" -- --en

echo ""
echo "=========================================================="
echo " SafeLine installation complete."
echo " Save the admin URL, username, and password printed above"
echo " -- the password is shown only once."
echo ""
echo " Management UI: https://<Ubuntu-IP>:9443"
echo "=========================================================="
