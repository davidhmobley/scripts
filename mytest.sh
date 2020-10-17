#!/bin/bash

str="2. Hello {\"a\": \"cat\"\r, \"b\": \"dog\"\r}"
echo "Original: $str"

str=$(echo $str | tr -d '\\r')
echo "Modified: $str"

# separate out JSON from the string
nonjson=$(echo $str | cut -d'{' -f 1)
echo "NonJson: $nonjson"
json=$(echo $str | cut -d'{' -f 2)
json="{${json}"
echo "Json: $json"
echo "formatted json..."
echo $json | jq .