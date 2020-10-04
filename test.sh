#!/bin/bash

STR="/home/david/bin/dhm.sh"
echo "given $STR..."

echo ${STR%.sh}
echo ${STR%/*}
echo ${STR##*.}
echo ${STR##*/}
echo ${STR#*/}
echo ${STR##*/}

echo " "

echo "Enter name of DB:"
read dbName
echo "You entered $dbName"

echo " "

prettyPrint() {
	for ((i = 0 ; i < ${#1} ; i++)); do
	  printf "*"
	done
	printf "\n"
}

prettyPrint "this is a string yet another string"
echo "this is a string yet another string"
prettyPrint "this is a string yet another string"
