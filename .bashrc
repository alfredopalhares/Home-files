# BashRC 
# User specific shell enviroment

# Check for an interactive session
[ -z "$PS1" ] && return

###############
# 	 Vars	  #
###############

# The bash colors, keep it simple in here that show the repo and the current branch name 
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\W\[\e[0;31m\]$(__git_ps1 " (%s)")\[\e[m\]\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '

#The bash files directory
BASH_DIR="$HOME/.bash.d"


######################
#   Sourced files    #
######################

# Source de enviroment vars
if [[ -f $BASH_DIR/env_vars.bash ]]; then
	source $BASH_DIR/env_vars.bash
fi

# Source the aliases file
if [[ -f $BASH_DIR/aliases.bash ]]; then
	. $BASH_DIR/aliases.bash
fi

# Source the git completion file
if [[ -f $BASH_DIR/git_completion.bash ]]; then
	. $BASH_DIR/git_completion.bash
fi

# Source the Udisks functions file
if [[ -f $BASH_DIR/udisks_functions.bash ]]; then
	. $BASH_DIR/udisks_functions.bash
fi

