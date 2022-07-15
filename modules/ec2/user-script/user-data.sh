#!/bin/bash
yum update -y 
yum install httpd -y
systemctl start httpd
systemctl enable httpd
timedatectl set-timezone Australia/Sydney
echo "Greetings, Welcome to test-code Challenge Application - $(hostname -f). The instance up time is $(date)" > /var/www/html/index.html