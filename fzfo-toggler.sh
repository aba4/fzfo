#!/bin/bash
if [[ -z $(xdotool search --name ":fzfo") ]]; then
  echo "starting fzfo"
  alacritty -t ":fzfo" -e '$HOME/fzfo/fzfo.sh' > /dev/null 2>&1 &
  echo "1" > ~/.fzfowindowstate
else
  if [[ $(cat ~/.fzfowindowstate) == "1" ]]; then # launcher is mapped
    #echo "fzfo mapped... unmapping"
    if [[ $(xdotool getactivewindow) == $(xdotool search --name ":fzfo") ]]; then # launcher is focused
      xdotool search --name ":fzfo" windowunmap
      echo "0" > ~/.fzfowindowstate
    else
      xdotool search --name ":fzfo" windowactivate
    fi
  else
    #echo "fzfo unmapped... mapping"
    xdotool search --name ":fzfo" windowmap
    echo "1" > ~/.fzfowindowstate
  fi
fi
