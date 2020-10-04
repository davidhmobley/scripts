#!/bin/zsh

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# store the current dir
CUR_DIR=$(pwd)
cd ~/StudioProjects

# Let the person running the script know what's going on.
echo "Pulling in latest changes for all repositories..."

# Find all git repositories and update it to the master latest revision
for i in $(find . -mindepth 1 -maxdepth 1 -type d -print | cut -c 3-); do
    echo "";
    echo "$i";
    cd "/users/david/StudioProjects/$i";
	
	# under git control?
	if [ -d ".git" ]; then
		# get to the master branch
		git checkout master

	    # finally pull
	    git pull origin master;
	else
		echo "*** $i not under git control, skipping"
	fi	
done

# lets get back to the CUR_DIR
cd $CUR_DIR

IFS=$SAVEIFS

echo "Complete!"