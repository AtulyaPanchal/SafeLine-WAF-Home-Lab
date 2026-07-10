#!/bin/bash
# 01-ubuntu-lamp-setup.sh
# Run on the Ubuntu Server 22.04 LTS VM.
# Installs base tools and the LAMP stack (Linux, Apache, MySQL, PHP).

set -e

echo "[+] Updating package index and upgrading system..."
sudo apt-get update
sudo apt-get upgrade -y

echo "[+] Installing essential networking and SSL tools..."
sudo apt-get install -y net-tools openssl curl git

echo "[+] Installing Apache, PHP, and MySQL..."
sudo apt-get install -y apache2 php php-mysql mysql-server php-gd php-xml

echo "[+] Enabling required PHP extensions..."
sudo phpenmod gd

echo "[+] Verifying Apache status..."
sudo systemctl status apache2 --no-pager || true

echo "[i] Next step: run 'sudo mysql_secure_installation' manually to set your MySQL root password."
echo "[i] Then continue with 02-dvwa-install.sh"
