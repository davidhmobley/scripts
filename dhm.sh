#!/bin/bash

usage() {
	echo "Usage: `basename $0` [-x] [-d <dev|test|staging>] [-t <target>] string"
	
	exit
}

prettyPrint() {
	for ((i = 0 ; i < ${#1} ; i++)); do
	  printf "*"
	done
	printf "\n"
}

# get out if nothing passed in
if [ $# -eq 0 ]; then
	usage
fi

str=""
xarg=1 # false
environment=""
target=""
stop=1 # false

# process commandline args
while getopts ":xd:t:" opt; do
  case ${opt} in
    x )
      xarg=0 # true
      ;;
    t )
      target=$OPTARG
      ;;
    d )
      environment=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
	  stop=0 #true
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
	  stop=0 #true
      ;;
  esac
done
shift $((OPTIND -1))

# encountered an anomaly in processing commandline args?
if [ $stop -eq 0 ]; then
	usage
fi

# nothing left? get out
if [ $# -eq 0 ]; then
	usage
fi

# verify -d arg
if [ ! $environment == "dev" ] && [ ! $environment == "test" ] && [ ! $environment == "staging" ]; then
	usage
fi

# should be only one commandline arg left
if [ $# -eq 1 ]; then
	str=$1
else
	usage
fi

# build command string
#command="$0"
command=`basename $0`
if [ $xarg -eq 0 ]; then
    command="$command -x" 
fi
if [ -n "$environment" ]; then
	command="$command -d $environment"
fi
if [ -n "$target" ]; then
	command="$command -t $target"
fi
command="$command $str"

prettyPrint "$command"
echo "$command"
prettyPrint "$command"

