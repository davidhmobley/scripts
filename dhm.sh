#!/bin/bash

usage() {
	echo "Usage: ${0##*/} [-d <dev|test|staging>] [-t <target>] string"
	
	exit
}

# get out if nothing passed in
if [ $# -eq 0 ]; then
	usage
fi

str=""
environment=""
target=""
stop=1 # false

# process commandline args
while getopts ":d:t:" opt; do
  case ${opt} in
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
command="${0##*/}"
if [[ -n "$environment" ]]; then
	command="$command -d $environment"
fi
if [[ -n "$target" ]]; then
	command="$command -t $target"
fi
command="$command $str"
echo "==> $command <=="

