#!/bin/bash
yum update -y 
yum install httpd -y
systemctl start httpd
systemctl enable httpd
timedatectl set-timezone ${timezone}
#aws s3 cp s3://belong-coding-challenge/belong-test.html /var/www/html/index.html
aws s3 cp s3://sanjay-rohilla/belong-test.html /var/www/html/index.html