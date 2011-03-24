#!bash

# The bash aliases files 
# Set all the aliases here

# Global aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Git relatead alias
alias gc='git commit'
alias ga='git add'
alias gls='git ls-files'
alias glg='git log'
alias gp='git push'
alias gpl='git pull'

# Minecraft alias to use the ssh tunnel at port 9999
alias minecraft_socks='java -Xmx1024M -Xms512M -DsocksProxyHost=127.0.0.1 -DsocksProxyPort=9999 -cp     /usr/share/minecraft/minecraft.jar net.minecraft.LauncherFrame'
