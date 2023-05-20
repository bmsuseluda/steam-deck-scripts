#!/bin/bash

xrandr -o inverted

steamPid=$(pidof steam)

echo $steamPid
if [[ -n $steamPid ]]; then
	echo 'kill steam'
	kill $steamPid
	sleep 10s && steam -tenfoot
else
	echo 'start big picture mode'
	steam -tenfoot
fi

exit 0
