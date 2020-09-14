#!/bin/bash
yum install -y epel-release
yum update
yum install -y nginx
systemctl start nginx.service
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --zone=public --permanent --add-service=https
sudo firewall-cmd --reload
