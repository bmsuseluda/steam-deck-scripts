#!/bin/bash

buildInScreen="eDP"

# Rotate external screen if connected, else steam deck buildIn screen
function rotateScreen {
  screens="$(xrandr | grep -Po '().+(?= connected)')"
  countScreens="$(echo "$screens" | wc -l)"

  if [ "$countScreens" = 1 ]; then
    # Rotate steam deck buildIn screen
    xrandr --output "$buildInScreen" --rotate inverted
  else
    # Rotate external screen
    externalScreen="$(echo "$screens" | grep -m2 "" | tail -n1)"
    xrandr --output "$externalScreen" --rotate right

    # Set steam deck buildIn screen off
    xrandr --output "$buildInScreen" --off
  fi
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
