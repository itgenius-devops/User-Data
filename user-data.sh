#!/bin/bash

# Update package lists and install necessary packages
sudo apt update
sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql wget

# Download and extract the latest WordPress
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz

# Copy WordPress files to the web server directory
sudo cp -r wordpress/* /var/www/html

# Secure MySQL installation (optional but recommended)
sudo mysql_secure_installation

# Set up WordPress configuration
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Set proper ownership and permissions
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# Start and enable Apache service
sudo systemctl start apache2
sudo systemctl enable apache2

