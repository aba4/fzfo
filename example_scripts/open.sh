# This should work but doesn't exactly lol. It screws up fzf for some reason
# Regardless, this is an example of fzfo opening another instance of fzf to open a file
nohup gtk-launch $(ls "$HOME/.local/share/applications" "/usr/share/applications/" | fzf) &
