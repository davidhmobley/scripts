#!/bin/bash

str="2. Hello {\"a\", \"b\"}"
echo "Original: $str"

# separate out JSON from the string
nonjson=$(echo $str | cut -d'{' -f 1)
echo "NonJson: $nonjson"
json=$(echo $str | cut -d'{' -f 2)
json="{${json}"
echo "Json: $json"