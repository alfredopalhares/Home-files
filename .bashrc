# BashRC 
# User specific shell enviroment

# Check for an interactive session
[ -z "$PS1" ] && return

###############
# 	 Vars	  #
###############

# The bash colors, keep it simple in here
PS1='[\u@\h \W]\$ '

#The bash files directory
BASH_DIR="$HOME/.bash.d"


######################
#   Sourced files    #
######################

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

