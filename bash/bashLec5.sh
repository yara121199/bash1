#!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob


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
                                    read -p "please enter number of fields" num_fields
                                    echo "Please make sure that the first field is the PRIMARY KEY"
                                   arr=()
                                   dataTypeArr=()
                                   declare -i i=0
                                    while ((i < num_fields))
                                    do
                                      read -p "please enter field name " field_name
                                      name=$field_name":"
                                      read -p "please enter field Data Type " dataType_name
                                      type=$dataType_name":"
                                       arr+=$name
                                       dataTypeArr+=$type
                                       ((i=$i+1))
                                    done
                                    echo ${arr[0]} >> ./$tb_name
                                    echo ${dataTypeArr[0]} >> ./$tb_name
                                    echo "Your table is created Successfully"
                                  else
                                    echo "Your table name is invalid you should start with letters and it only contains small and capital and numbers only"

                                  fi
                        ;;
                        "Insert Table")
                          read -p "Enter your table name " tb_name
                          if [ -f $tb_name ];then
                            data=()
                            declare -i index=0
                             while ((index < `head -n1 ./$tb_name | grep -o ":" | wc -l`))
                             do
                               read -p "please insert data of col ${index} " col_value
                               dt=$col_value":"
                                data+=$dt
                                ((index=$index+1))
                             done
                             echo ${data[0]} >> ./$tb_name
                          else
                            echo "you havn't a table with this name"
                          fi

                          ;;
                        "Drop Table")
                          read -p "Enter your table name " tb_name
                          if [ -f $tb_name ];then
                             rm  tb_name
                          else
                            echo "you havn't a table with this name"
                          fi
                          ;;
                        "Select Table")
                         read -p "Enter your table name " tb_name
                        if [ -f $tb_name ];then
                          while true
                            do
                              select choice in "All"  "Field by primary key"  "Column" "Exit"
                                do
                                  case $choice in
                                    "All")
                                    cat ./$tb_name
                                    ;;
                                    "Field by primary key")
                                    read -p "Enter the Primary key " prim
                                    my_array=()
                                      declare -i index=3
                                      IFS=$'\n' read -r -d '' -a my_array < <( sed -n '3,$p' $tb_name | cut -d : -f1 && printf '\0' )
                                     for i in "${my_array[@]}"
                                      do
                                        if [[ "${i}" == "${prim}" ]]
                                        then
                                          awk 'FNR=='$index $tb_name
                                        fi
                                        ((index=$index+1))
                                      done
                                    ;;
                                    "Column")
                                    read -p "Enter your column name " col_name
                                      line=$(head -n 1 $tb_name)
                                      IFS=':' read -r -a ar <<< "$line"
                                      declare -i index=0
                                      declare -i in=0
                                      for i in "${ar[@]}"
                                      do
                                        ((in=$in+1))
                                        if [[ "${i}" == "${col_name}" ]]
                                          then
                                           ((index = $in))
                                        fi
                                      done
                                     cut -d : -f$index $tb_name
                                    ;;
                                    "Exit")
                                    break
                                    ;;
                                    *)
                                    echo "Please choose a correct answer"
                                  esac
                                done
                            done
                          else
                            echo "you havn't a table with this name"
                        fi
                          ;;
                        "Delete Table")
                           read -p "Enter your table name " tb_name
                          if [ -f $tb_name ];then
                           sed -i  '3,$d' $tb_name
                          else
                            echo "you havn't a table with this name"
                          fi
                          ;;
                        "Update Table")
                           read -p "Enter the table name " tb_name
                            line=$(head -n 1 $tb_name)
                            IFS=':' read -r -a ar <<< "$line"
                            read -p "Enter the col name " col_name
                                      declare -i index=0
                                      declare -i in=0
                                      for i in "${ar[@]}"
                                      do
                                        if [[ "${ar[in]}" == "${col_name}" ]]
                                          then
                                           ((index = $in+1))
                                        fi
                                      ((in=$in+1))
                                      done
                                      d=()
                             d=$(cut -d : -f$index $tb_name)
                             IFS=$'\n' read -r -a ary <<< "$d"
                             echo "${ary[@]}"
                           read -p "Enter the old data" old_data
                           read  -p "Enter your new data" data

                          ;;
                        "List Tables")
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




