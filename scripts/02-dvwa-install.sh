#!/bin/bash
# 02-dvwa-install.sh
# Run on the Ubuntu Server VM after 01-ubuntu-lamp-setup.sh.
# Clones DVWA, sets permissions, creates the database, and
# switches Apache to port 8080 so SafeLine WAF can own 443/80.

set -e

DB_NAME="dvwa"
DB_USER="dvwa_user"
DB_PASS="p@ssw0rd"   # CHANGE THIS for your own lab

echo "[+] Cloning DVWA into /var/www/html/DVWA ..."
cd /var/www/html
sudo git clone https://github.com/digininja/DVWA.git

echo "[+] Setting file ownership and permissions..."
sudo chown -R www-data:www-data /var/www/html/DVWA
sudo chmod -R 755 /var/www/html/DVWA

echo "[+] Creating DVWA config file..."
cd /var/www/html/DVWA/config
sudo cp config.inc.php.dist config.inc.php
sudo sed -i "s/\$_DVWA\[ 'db_database' \].*/\$_DVWA[ 'db_database' ] = '${DB_NAME}';/" config.inc.php
sudo sed -i "s/\$_DVWA\[ 'db_user' \].*/\$_DVWA[ 'db_user' ] = '${DB_USER}';/" config.inc.php
sudo sed -i "s/\$_DVWA\[ 'db_password' \].*/\$_DVWA[ 'db_password' ] = '${DB_PASS}';/" config.inc.php
sudo sed -i "s/\$_DVWA\[ 'db_server' \].*/\$_DVWA[ 'db_server' ] = '127.0.0.1';/" config.inc.php

echo "[+] Creating MySQL database and user..."
sudo mysql -u root -p <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
EOF

echo "[+] Switching Apache to port 8080..."
sudo sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf
sudo sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/' /etc/apache2/sites-available/000-default.conf
sudo systemctl restart apache2

echo "[+] Verifying DVWA responds on port 8080..."
curl -I http://localhost:8080/DVWA/ || true

echo "[i] Now open http://<Ubuntu-IP>:8080/DVWA/setup.php in a browser and click 'Create / Reset Database'."
echo "[i] Default login: admin / password"
