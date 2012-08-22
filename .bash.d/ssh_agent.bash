# SHH Agent script
tempfile=/tmp/ssh-agent.test
#Check for an existing ssh-agent
if [[ ! -e $tempfile ]]
then
  echo "Creating a ssh-agent"
  ssh-agent -s > $tempfile
fi
source $tempfile > /dev/null
