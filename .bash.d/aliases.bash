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
alias glgpretty='git log --pretty=format:'%h : %s' --graph'
alias gp='git push'
alias gpl='git pull'

# Alias to shutdown using policykit
alias ck_shutdown='dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop'
alias ck_reboot='dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart'
alias ck_suspend='dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend'
# alias ck_hibernate='dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Hibernate'

# Minecraft alias to use the ssh tunnel at port 9999
alias minecraft_socks='java -Xmx1024M -Xms512M -DsocksProxyHost=127.0.0.1 -DsocksProxyPort=9999 -cp     /usr/share/minecraft/minecraft.jar net.minecraft.LauncherFrame'
