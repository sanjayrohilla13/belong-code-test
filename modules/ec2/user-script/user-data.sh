#!/bin/bash
yum update -y 
yum install httpd -y
systemctl start httpd
systemctl enable httpd
timedatectl set-timezone Australia/Sydney
s3:/belong-coding-challenge/belong-test.html > /var/www/html/index.html