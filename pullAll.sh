#!/bin/zsh

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

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# store the current dir
CUR_DIR=$(pwd)
cd ~/StudioProjects

# Let the person running the script know what's going on.
echo "Pulling in latest changes for all repositories..."

# Find all git repositories and update it to the master latest revision
for project in $(find . -mindepth 1 -maxdepth 1 -type d -print | cut -c 3-); do
    echo "$project";
	prettyPrint "$project"
	
    cd ~/StudioProjects/$project
	
	# under git control?
	if [[ -d ".git" ]]; then
		branch=`git branch --show-current`
		
		# get to the master/main branch
		git checkout $branch

		# finally pull
	    git pull origin $branch;
	else
		echo "*** not under git control, skipping"
	fi	

    echo "";
done

# lets get back to the CUR_DIR
cd $CUR_DIR

IFS=$SAVEIFS

echo "Complete!"
