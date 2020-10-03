#!/bin/bash

STR="/home/david/bin/dhm.sh"
echo "given $STR..."
echo ${STR%.sh}    # /path/to/foo
echo ${STR%/*}      # /path/to
echo ${STR##*.}     # cpp (extension)
echo ${STR##*/}     # foo.cpp (basepath)
echo ${STR#*/}      # path/to/foo.cpp
echo ${STR##*/}     # foo.cpp
echo ${STR/foo/bar} # /path/to/bar.cpp

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
