#!/bin/bash

buildInScreen="eDP"

# Resets orientation of external screen if connected, else steam deck buildIn screen
function resetScreenOrientation {
  screens="$(xrandr | grep -Po '().+(?= connected)')"
  countScreens="$(echo "$screens" | wc -l)"

  if [ "$countScreens" = 1 ]; then
    # Reset steam deck buildIn screen
    xrandr --output "$buildInScreen" --rotate right
  else
    # Reset external screen
    externalScreen="$(echo "$screens" | grep -m2 "" | tail -n1)"
    xrandr --output "$externalScreen" --rotate normal

    # Set steam deck buildIn screen on
    xrandr --output "$buildInScreen" --auto
  fi
}

resetScreenOrientation

exit 0