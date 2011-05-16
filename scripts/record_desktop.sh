# Easy way of record the desktop
dimensions=`xdpyinfo | grep 'dimensions:'|awk '{print $2}'`
output="/tmp/out.mpg"

ffmpeg -f x11grab -s  $dimensions -r 25 -i :0.0 -sameq $output
