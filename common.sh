mysql_root_password=$1
LOG=/tmp/expense.log

print_Head (){
  echo $1
  echo "################## $1 #################" &>>$LOG
}