mysql_root_password=$1

print_Head (){
  echo $1
  echo "################## $1 #################" &>>/tmp/expense.log
}

print_Head "Disable nodejs"
dnf module disable nodejs -y &>> /tmp/expense.log

print_Head "Enable nodejs"
dnf module enable nodejs:20 -y &>> /tmp/expense.log

print_Head "Install nodejs"
dnf install nodejs -y &>> /tmp/expense.log

print_Head "Add user"
useradd expense

print_Head "Copy service file to Systemd"
cp backend.service /etc/systemd/system/backend.service

print_Head "Creating Directory"
mkdir /app

rm -rf /app/*
print_Head "Download App content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>> /tmp/expense.log

print_Head "Unzip app content"
cd /app

unzip /tmp/backend.zip &>> /tmp/expense.log

print_Head "install nodejs dependencies npm package"
npm install &>> /tmp/expense.log

print_Head "Starting Backend.."
systemctl daemon-reload &>> /tmp/expense.log
systemctl enable backend &>> /tmp/expense.log
systemctl start backend &>> /tmp/expense.log

print_Head "Install mysql client"
dnf install mysql -y &>> /tmp/expense.log

print_Head "Setup Schema"
mysql -h 172.31.31.217 -uroot -p${mysql_root_password} < /app/schema/backend.sql

