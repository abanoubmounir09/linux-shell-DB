#!/usr/bin/bash
#v1=1
#v2=1
select choice in create list  connect drop exite
do
case $choice in
create) echo enter database name
#v1=0
mkdir -p db
read dbname
cd db
mkdir $dbname
cd $dbname
#echo enter num of tables
#read num
#typeset x 
#for (( c=1; c<=$num; c++ )) 
#do
#echo enter table name
#read tname
#touch $tname.csv
#done
cd ..
cd ..
;;
list) 
cd db 
ls
cd ..
#if [[ $v1 -lt $v2 ]]
#then
#echo "0"
#cd .. 
#ls
#else 
#echo "1"
#ls
#fi
;;
connect) echo enter name of database to connect
cd db
ls
read dbname
cd $dbname
select choice in CreateTable  ListTables  DropTable InsertIntoTable SelectFromTable DeleteFromTable exite
do
case $choice in
CreateTable)
echo enter num of tables
read num 
for (( c=1; c<=$num; c++ ))
do
echo enter table name
read tname
touch $tname.csv

echo enter num colm
read colmnum
	for (( t=1; t<=$colmnum; t++ ))
	do
	echo enter colm name
	read colmname
	sep=${colmname}':\t'
	printf $sep >> $tname.csv
	done;
    echo  colm created
  printf '\n' >> $tname.csv
done
;;
ListTables)
#find . $tname.csv
ls | grep '\.csv$' 
;;
InsertIntoTable)
pwd
#------get colms att num
echo enter table name
read tableName
awk -F: '{ print (NR==1) ?  NF :""}' $tableName.csv > c.txt
#------- get firrst row
tableAttr=$(awk '{ print (NR==1) ?  $0 :""}' $tableName.csv)
var=$(<c.txt)
#enter data in table
echo ${tableAttr[0]}
for (( c=1; c<var; c++ ))
do
echo enter value
read value
sep=${value}':'
printf $sep >> $tableName.csv
done
printf '\n' >> $tableName.csv
;;
SelectFromTable)
#-------select data
echo enter table name
read name
cat $name.csv
;;
DeleteFromTable)
#delete row
echo enter table name
read name
echo enter num of deleted row
read num
declare -i x=1
declare -i y=$num
declare -i z=0
z=$(( y + x ))
sed -i $z'd' $name.csv
;;
exite)
exit
;;
DropTable) echo enter name of table
read tname
rm $tname.csv
;;
esac
done
;;
drop)echo enter name of database to delete
echo "found database"
cd db 
ls
read dbname
rm -r $dbname
cd ..
;;
exite)
exit
;;
*) echo $REPLY is not one of the choices.
;;
esac
done


