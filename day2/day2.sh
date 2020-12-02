#!/bin/bash

file="day2.input"

function challenge1() {
  count=`echo $4 | tr -cd $3 | wc -c`
  [ ! $1 -le $count ] || [ ! $count -le $2 ]
  return $?
}

function challenge2() {
  [ ! ${4:$(($1-1)):1} == $3 ]
  count=$?
  [ ! ${4:$(($2-1)):1} == $3 ]
  count=$(( count + $? ))
  return $(($count%2))
}

count1=0
count2=0

while read line;
do
  linearray=($line)
  read -r lo hi <<< ${linearray[0]/-/ }
  char=${linearray[1]%:}
  password=${linearray[2]}
  
  challenge1 $lo $hi $char $password
  count1=$((count1 + $?))
  challenge2 $lo $hi $char $password
  count2=$((count2 + $?))

done < $file

echo Challenge 1: $count1
echo Challenge 2: $count2
