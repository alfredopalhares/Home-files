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
BASH_DIR='~/.bash.d'


######################
#   Sourced files    #
######################

# Source the aliases file
if [[ -f $BASHDIR/aliases.bash ]]; then
	. $BASHDIR/aliases.bash
fi

# Source the git completion file
if [[ -f $BASHDIR/git_completion.bash ]]; then
	. $BASHDIR/git_completion.bash
fi

# Source the Udisks functions file
if [[ -f $BASHDIR/udisks_functions.bash ]]; then
	. $BASHDIR/udisks_functions.bash
fi

