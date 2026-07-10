#!/bin/bash
# 03-ssl-cert-generate.sh
# Run on the Ubuntu Server VM.
# Generates a self-signed SSL certificate for dvwa.local,
# which SafeLine WAF will use to terminate HTTPS traffic.

set -e

CERT_DIR="/etc/ssl/dvwa"

echo "[+] Creating certificate directory..."
sudo mkdir -p "${CERT_DIR}"

echo "[+] Generating 2048-bit RSA key and self-signed certificate (365 days)..."
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "${CERT_DIR}/dvwa.key" \
  -out "${CERT_DIR}/dvwa.crt" \
  -subj "/C=US/ST=Lab/L=HomeLab/O=DVWA-Lab/CN=dvwa.local"

echo "[+] Certificate files:"
ls -lh "${CERT_DIR}/"

echo "[i] To view the cert in SafeLine's UI, copy the contents with:"
echo "    sudo cat ${CERT_DIR}/dvwa.crt"
echo "    sudo cat ${CERT_DIR}/dvwa.key"
echo "[i] Paste these into SafeLine's Certificate / Private Key fields under Settings > Certificates."
