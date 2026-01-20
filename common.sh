mysql_root_password=$1

print_Head (){
  echo $1
  echo "################## $1 #################" &>>/tmp/expense.log
}