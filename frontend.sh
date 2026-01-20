set -x
echo "Install Nginx"
dnf install nginx -y &>>/tmp/expense.log

echo "copy nginx Reverse proxy conf file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
echo "Remove Old content"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log
echo "Download App content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log
echo "Unzip the content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/expense.log

echo "Start Nginx"
systemctl enable nginx &>>/tmp/expense.log
systemctl start nginx &>>/tmp/expense.log
