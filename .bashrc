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
if [[ -f $BASHDIR/aliases.sh ]]; then
	. $BASHDIR/aliases.sh
fi


