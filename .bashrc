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


# Source the aliases file
if [[ -f $BASHDIR/aliases.bash ]]; then
	. $BASHDIR/aliases.bash
fi

# Source the git completion file
if [[ -f $BASHDIR/git_completion.bash ]]; then
	. $BASHDIR/git_completion.bash
fi

