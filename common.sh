mysql_root_password=$1
LOG=/tmp/expense.log

print_Head (){
  echo $1
  echo "################## $1 #################" &>>$LOG
}
print_Status(){
 if [ $? -eq 0 ]; then
     echo -e "\e[32m:1Success\e[0m"
  else
    echo -e "\e[31m:1Failure\e[0m"
 fi
}