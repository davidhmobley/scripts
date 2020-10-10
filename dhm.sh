#!/bin/bash

usage() {
	echo "Usage: `basename $0` [-x] [-e {dev|test|staging}] [-t <target>] string"
	
	exit
}

# line separator
prettyPrint() {
    chars=$1
    firstChar=1 #false

    for ((i = 0 ; i < ${#chars} ; i++)); do
        # any blanks prefixing the line?
        if [[ $firstChar -eq 1 ]]; then
            if [[ ${chars:$i:1} == " " ]]; then
                printf " " 
            else
                firstChar=0 #true
            fi
        else
            printf "*"
        fi
    done
    printf "\n"
}

xarg=1 # false
stop=1 # false
str=""
environment=""
target=""

# process commandline args
while getopts ":xe:t:" opt; do
  case ${opt} in
    x )
      xarg=0 # true
      ;;
    t )
      target=$OPTARG
      ;;
    e )
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
if [[ $stop -eq 0 ]]; then
	usage
fi

# nothing left? get out
if [[ $# -eq 0 ]]; then
	usage
fi

# verify -e arg
if [[ ! $environment == "dev" ]] && [[ ! $environment == "test" ]] && [[ ! $environment == "staging" ]]; then
	usage
fi

# should be only one commandline arg left
if [[ $# -eq 1 ]]; then
	str=$1
else
	usage
fi

# build command string
command=`basename $0`
if [[ $xarg -eq 0 ]]; then
    command="$command -x" 
fi
if [[ -n "$environment" ]]; then
	command="$command -e $environment"
fi
if [[ -n "$target" ]]; then
	command="$command -t $target"
fi
command="$command $str"

prettyPrint "$command"
echo "$command"
prettyPrint "$command"

echo "    $command"
prettyPrint "    $command"
