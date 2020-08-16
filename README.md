# fzfo
A very simple launcher that uses fzf and bash

All this script does is pipe the files from a script directory into fzf and when the user makes a selection it sources the selected file

The main loop is very simple:

```bash
#!/bin/bash
SCRIPTDIR="PATH_TO_SCRIPTS_DIRECTORY"
while true; do cd "$SCRIPTDIR"; source $(ls "$SCRIPTDIR" | fzf); done
```

Then you combine that with a terminal (I use alacritty here because it starts really fast), xdotool (to map and unmap / hide and unhide the terminal window), and xbindkeys (to make a shortcut) in the following scripts. Note, this does create a file `~/.fzfowindowstate` in your home directory to manage the current mapping / hidden state of the window:

The FZF_WINDOW_TOGGLER script:

```bash
#!/bin/bash
if [[ -z $(xdotool search --name ":fzfo") ]]; then
  echo "starting fzfo"
  alacritty -t ":fzfo" -e 'PATH_TO_FZFO_SCRIPT' > /dev/null 2>&1 &
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
```

Finally, put this into your `~/.xbindkeysrc`:

```
"exec PATH_TO_FZF_WINDOW_TOGGLER_SCRIPT"
   Control + Alt + Tab
```

Change the `Control + Alt + Tab` to whatever you want, I think `Alt + Tab` is usually available but you might have to stop any programs already using that combination


I've included some example scripts in the example_scripts directory so you can get a feel for it.

My primary reason for making this and using it is because it is very extendible, powerful, and very fast
