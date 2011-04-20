#!/bin/bash
# Simple script to export vars to my repositories with detached worktrees
# Last change 20th, April of 2011


# Export varrs for the home repository
home(){
	export GIT_DIR="$HOME/Documents/config_files/dot.git"
	export GIT_WORK_TREE="$HOME"
}

# Export vars for the etc repository
etc(){
	export GIT_DIR="$HOME/Documents/config_files/etc.git"
	export GIT_WORK_TREE="/etc/"
}

# Unload vars
unload(){
	unset GIT_DIR
	unset GIT_WORK_TREE
	echo "Vars removed"
}

# Show vars status
status() {
	echo "Directory: $GIT_DIR"
	echo "Wortree: $GIT_WORK_TREE"
}

case $1 in
	home)
		home
	;;
	etc)
		etc
	;;
	unload)
		unload
	;;	
	status)
		status
	;;
esac
