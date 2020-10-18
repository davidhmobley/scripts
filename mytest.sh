#!/bin/bash

str="2. Hello {\"a\": \"cat\"\r, \"b\": [{\"c\": \"dog\"\r},{\"c\": \"frog\"}]}"
echo "Original: $str"
echo " "
str=$(echo $str | tr -d '\\r')
echo "Modified: $str"
echo " "

# separate out JSON from the string
nonjson=$(echo $str | cut -d '{' -f 1)
echo "NonJson: $nonjson"
echo " "
json=$(echo $str | cut -d '{' -f 2-)
json="{${json}"
echo "Json: $json"
echo " "
echo "formatted json..."
echo $json | jq .
