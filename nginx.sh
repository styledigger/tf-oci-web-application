#!/bin/bash
yum install -y epel-release
yum update
yum install -y nginx
systemctl start nginx.service
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload
