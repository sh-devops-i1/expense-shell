set -x
mysql_root_password=$1

echo "Install MySQL Server"
dnf install mysql-server -y &>> /tmp/expense.log

echo "Start MySQL"
systemctl enable mysqld &>> /tmp/expense.log
systemctl start mysqld &>> /tmp/expense.log

echo "Setup MySQL Root password"
mysql_secure_installation --set-root-pass ${mysql_root_password} &>> /tmp/expense.log
