#!bin/bash

# Set the variable to skype recongize my webcam right
# otherwise it will be upside-down 
# LAST UPDATE: 30 Nov 2010

export LD_PRELOAD=/usr/lib32/libv4l/v4l1compat.so
skype
unset LD_PRELOAD

exit 0
