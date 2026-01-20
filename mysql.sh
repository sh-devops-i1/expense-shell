source common.sh

print_Head "Install MySQL Server"
dnf install mysql-server -y &>> $LOG

print_Head "Start MySQL"
systemctl enable mysqld &>> $LOG
systemctl start mysqld &>> $LOG

print_Head "Setup MySQL Root password"
mysql_secure_installation --set-root-pass ${mysql_root_password} &>> $LOG
