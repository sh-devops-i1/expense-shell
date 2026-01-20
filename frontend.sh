set -x
print_Head (){
  echo $1
  echo "################## $1 #################" &>>/tmp/expense.log
}


print_Head "Install Nginx"
dnf install nginx -y &>>/tmp/expense.log

print_Head "copy nginx Reverse proxy conf file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
print_Head "Remove Old content"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log
print_Head "Download App content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log
print_Head "Unzip the content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/expense.log

print_Head "Start Nginx"
systemctl enable nginx &>>/tmp/expense.log
systemctl start nginx &>>/tmp/expense.log
