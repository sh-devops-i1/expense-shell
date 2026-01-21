#!/bin/bash

source ./common.sh
app_dir=/usr/share/nginx/html
component=frontend


print_Head "Install Nginx"
dnf install nginx unzip -y &>>$LOG
print_Status $0

print_Head "copy nginx Reverse proxy conf file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
print_Status $0

app_pre_req

print_Head "Start Nginx"
systemctl enable nginx &>>$LOG
systemctl start nginx &>>$LOG
print_Status $0
