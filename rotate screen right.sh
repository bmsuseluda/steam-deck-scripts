#!/bin/bash

# Rotate external screen if connected, else steam deck screen
function rotateScreen {
  screens="$(xrandr | grep -Po '().+(?= connected)')"
  countScreens="$(echo "$screens" | wc -l)"

  if [ "$countScreens" = 1 ]; then
    # Rotate steam deck screen
    screenToRotate="$(echo "$screens" | grep -m1 "")"
    rotation="inverted"
  else
    # Rotate external screen
    screenToRotate="$(echo "$screens" | grep -m2 "" | tail -n1)"
    rotation="right"
  fi

  xrandr --output "$screenToRotate" --rotate "$rotation"
}

# Start steam in big picture mode. Closes already running steam instance before.
function startSteamInBigPictureMode {
  steamPid="$(pidof steam)"

  echo "$steamPid"
  if [[ -n $steamPid ]]; then
    echo 'kill steam'
    kill "$steamPid"
    sleep 10s && steam -tenfoot
  else
    echo 'start big picture mode'
    steam -tenfoot
  fi
}

rotateScreen
startSteamInBigPictureMode && source 'reset screen orientation.sh'

exit 0
