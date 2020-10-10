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

