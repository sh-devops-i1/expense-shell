set -x
mysql_root_password=$1
echo "Disable nodejs"
dnf module disable nodejs -y &>> /tmp/expense.log
echo "Enable nodejs"
dnf module enable nodejs:20 -y &>> /tmp/expense.log
echo "Install nodejs"
dnf install nodejs -y &>> /tmp/expense.log
echo "Add user"
useradd expense
echo "Copy service file to Systemd"
cp backend.service /etc/systemd/system/backend.service
echo "Creating Directory"
mkdir /app
echo "Download App content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>> /tmp/expense.log
echo "Unzip app content"
cd /app
unzip /tmp/backend.zip &>> /tmp/expense.log
echo "install nodejs dependencies npm package"
npm install &>> /tmp/expense.log

echo "Starting Backend.."
systemctl daemon-reload &>> /tmp/expense.log
systemctl enable backend &>> /tmp/expense.log
systemctl start backend &>> /tmp/expense.log

echo "Install mysql client"
dnf install mysql -y &>> /tmp/expense.log

echo "Setup Schema"
mysql -h 172.31.31.217 -uroot -p${mysql_root_password} < /app/schema/backend.sql

