#!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob
#sed -n '/lp/p' /etc/passwd
#sed -n '3!p' /etc/passwd
#3---
#sed -n '/lp/!p' /etc/passwd
#5----------
#awk -F':' '
#BEGIN {}
#{print $5;}
#END{print "END";}' /etc/passwd

#awk -F':' '
#BEGIN {}
#print $5;
#}
#END{print "END";}' /etc/passwd

#awk -F':' '
#BEGIN {}
#{
#if($3>500){print $3;
#print $5;
#}}
#END{print "END";}' /etc/passwd


#awk -F':' '
#BEGIN {}
#{if($3==500){print $3;
#print $5;
#}}
#END{print "END";}' /etc/passwd

#awk -F':' '
#BEGIN {}
#{if(NR>5&&NR<15){print $0;}}
#END{print "END";}' /etc/passwd
#6-----------
#awk -F':' '
#BEGIN {
#line=""
#max=0}
#{if($3>max){max=$3
#line=$0
#}}
#END{print line;}' /etc/passwd


#awk -F':' '
#BEGIN {
#count=0}
#{count=count+$3
#}
#END{print count;}' /etc/passwd

#awk -F':' '
#BEGIN { getline m_gid; sum_uid=0 }
#{
#if($4==m_gid)
 # sum_uid += $3
  #}
#END { printf "Sum of UID = %d", sum_uid }' /etc/#passwd
#alias c="cd /DB"

rej='^[A-Z | a-z][A-Za-z0-9]+$'
if [ -d "DB" ];then
      cd ./DB
      echo "Your are connected to the engine now"
  else
    mkdir ./DB
    cd ./DB
    echo "Your are connected weweqeqewto the engine now"
fi
while true
do
  select choice in "Create DB"  "List DB"  "Drop DB"  "Connect DB"
   do
     case $choice in
       "Create DB")
             read -p "Enter Your DB name " db_name
          if [ -d $db_name ];then
                echo "Your DB is already exist"
                break
          fi

          if [[ ${db_name} =~ $rej ]]
          then
            mkdir ./$db_name
            echo "Your DB is created Successfully"
          else
            echo "Your Db name is invalid you should start with letters and it only contains small and capital and numbers only"

          fi

       ;;
      "List DB")
       ls -a
      ;;
      "Drop DB")
          read -p "Enter Your DB name " db_name
          if [ -d $db_name ];then
                rm -r $db_name
                echo "your DB has Successfully droped"
            else
              echo "your DB is not exist"
          fi
      echo
      ;;
      "Connect DB")
        read -p "Enter Your DB name " db_name
          if [ -d $db_name ];then
           cd $db_name
              while true
                   do
                    select choice in "Create Table"  "Insert Table"  "Drop Table"  "Select Table" "Delete Table" "Update Table" "List Table"
                      do
                        case $choice in
                        "Create Table")
                                  read -p "Enter your table name " tb_name
                                  if [ -f $tb_name ];then
                                        echo "Your table is already exist"
                                        break
                                  fi

                                  if [[ ${tb_name} =~ $rej ]]
                                  then
                                    touch ./$tb_name
                                    echo "Your table is created Successfully"
                                  else
                                    echo "Your table name is invalid you should start with letters and it only contains small and capital and numbers only"

                                  fi
                        ;;
                        "Insert Table")
                          echo
                          ;;
                        "Drop Table")
                          read -p "Enter your table name " tb_name
                          rm -r tb_name
                          ;;
                        "Select Table")
                          read -p "Enter your table name " tb_name
                          cat tb_name
                          ;;
                        "Delete Table")
                          if [ -f $tb_name ];then
                          echo -n '' > tb_name
                          else
                            echo "you havn't a table with this name"
                          fi
                          ;;
                        "Update Table")
                          echo
                          ;;
                        "List Table")
                          ls -a
                          ;;
                         *)
                           "Please Choose a correct answer"
                      esac
                    done
                done
            else
            echo "your DB is not exist"
            fi
      ;;
      *)
        echo "Please Enter A Correct Choice"
        ;;
      esac
    done
done




