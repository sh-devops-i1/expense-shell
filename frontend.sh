#!/bin/bash

source ./common.sh

print_Head "Install Nginx"
dnf install nginx unzip -y &>>$LOG
print_Status $0

print_Head "copy nginx Reverse proxy conf file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
print_Status $0

print_Head "Remove Old content"
rm -rf /usr/share/nginx/html/* &>>$LOG
print_Status $0

print_Head "Download App content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>$LOG
print_Status $0

print_Head "Unzip the content"
cd /usr/share/nginx/html || exit 1
unzip -o /tmp/frontend.zip &>>$LOG
print_Status $0

print_Head "Start Nginx"
systemctl enable nginx &>>$LOG
systemctl start nginx &>>$LOG
print_Status $0
