source common.sh

print_Head "Install MySQL Server"
dnf install mysql-server -y &>> /tmp/expense.log

print_Head "Start MySQL"
systemctl enable mysqld &>> /tmp/expense.log
systemctl start mysqld &>> /tmp/expense.log

print_Head "Setup MySQL Root password"
mysql_secure_installation --set-root-pass ${mysql_root_password} &>> /tmp/expense.log
