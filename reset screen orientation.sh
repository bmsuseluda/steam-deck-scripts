#!/bin/bash

# Resets orientation of external screen if connected, else steam deck screen
function resetScreenOrientation {
  echo "reset"
  screens="$(xrandr | grep -Po '().+(?= connected)')"
  countScreens="$(echo "$screens" | wc -l)"

  if [ "$countScreens" = 1 ]; then
    # Reset steam deck screen
    screenToReset="$(echo "$screens" | grep -m1 "")"
    rotation="right"
  else
    # Reset external screen
    screenToReset="$(echo "$screens" | grep -m2 "" | tail -n1)"
    rotation="normal"
  fi

  xrandr --output "$screenToReset" --rotate "$rotation"
}

resetScreenOrientation

exit 0