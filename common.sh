mysql_root_password=$1
LOG=/tmp/expense.log

if [ -z $"{mysql_root_password}"  ]; then
    echo -e "\e[1:31mPlease Enter Password\e[0m"
    exit 2
fi


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
app_pre_req(){

  print_Head "Clean Old content"
  rm -rf ${app_dir} &>>$LOG
  print_Status $?

  print_Head "Creating Directory"
  mkdir {app_dir}
  print_Status $?

  print_Head "Download App content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>> $LOG
  print_Status $?

  print_Head "Extract app content"
  cd ${app_dir} &>> $LOG
  unzip /tmp/${component}.zip &>> $LOG
  print_Status $?

}