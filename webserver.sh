#!/bin/bash
# Install Apache Web Server
yum install -y httpd
# Download lab files
#wget "URL"
#unzip "downloadedfile.zip" /var/www/html/
# Turn on web server
systemctl enable httpd.service
systemctl start httpd.service
