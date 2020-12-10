#!/bin/bash

file="day2.input"

function challenge1() {
  # Count number of occurences of character in password
  count=`echo $4 | tr -cd $3 | wc -c`
  # Make sure count is not not within range
  [ ! $1 -le $count ] || [ ! $count -le $2 ]
  return $?
}

function challenge2() {
  # Check first index is not not character
  [ ! ${4:$(($1-1)):1} == $3 ]
  count=$?
  # Check second index is not not character
  [ ! ${4:$(($2-1)):1} == $3 ]
  count=$(( count + $? ))
  # Make sure only one passed
  return $(($count%2))
}

count1=0
count2=0

while read line;
do
  # Make array from space separated line
  linearray=($line)
  # lo and hi are extracted from #-# at first index
  read -r lo hi <<< ${linearray[0]/-/ }
  # char is second index stripped of :
  char=${linearray[1]%:}
  # password is third index 
  password=${linearray[2]}
  
  challenge1 $lo $hi $char $password
  count1=$((count1 + $?))
  challenge2 $lo $hi $char $password
  count2=$((count2 + $?))

done < $file

echo Challenge 1: $count1
echo Challenge 2: $count2
