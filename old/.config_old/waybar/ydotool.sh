#!/bin/sh
# make sure to make this script executable

if [[ "$1" =~ ^[0-9]+$ ]]; then
    $actualKey = $1 + 1
    ydotool key 125:1 $actualKey:1
    echo $1
elif [ "$1" = "view" ]; then 
    ydotool key 125:1 25:1 --key-delay=5
    echo $1
fi

# ps cax | grep ydotoold > /dev/null
# if [ $?  -eq 0 ]; then
#     echo "process run"
#     ydotoold
# else
#     echo "process no run"
# fi
#pkill -f ydotoold