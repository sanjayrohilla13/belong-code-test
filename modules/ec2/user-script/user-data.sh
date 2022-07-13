#!/bin/bash
yum update -y 
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "Greetings, Welcome to test-code Challenge Application - $(hostname -f)" > /var/www/html/index.html