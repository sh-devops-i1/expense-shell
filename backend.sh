set -e
source common.sh

print_Head "Disable nodejs"
dnf module disable nodejs -y &>> $LOG
print_Status $?

print_Head "Enable nodejs"
dnf module enable nodejs:20 -y &>> $LOG
print_Status $?

print_Head "Install nodejs"
dnf install nodejs -y &>> $LOG
print_Status $?

print_Head "Add user"
id expense &>>$LOG
if [ $? -ne 0 ]; then
useradd expense
fi

print_Head "Copy service file to Systemd"
cp backend.service /etc/systemd/system/backend.service
print_Status $?

print_Head "Clean Old content"
rm -rf /app/*
print_Status $?

print_Head "Creating Directory"
mkdir /app
print_Status $?


print_Head "Download App content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>> $LOG
print_Status $?

print_Head "Unzip app content"
cd /app
unzip /tmp/backend.zip &>> $LOG
print_Status $?

print_Head "install nodejs dependencies npm package"
npm install &>> $LOG
print_Status $?

print_Head "Starting Backend.."
systemctl daemon-reload &>> $LOG
systemctl enable backend &>> $LOG
systemctl start backend &>> $LOG
print_Status $?

print_Head "Install mysql client"
dnf install mysql -y &>> $LOG
print_Status $?

print_Head "Setup Schema"
mysql -h 172.31.29.34 -uroot -p${mysql_root_password} < /app/schema/backend.sql
print_Status $?

