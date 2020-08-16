#!/bin/bash
SCRIPTDIR="$HOME/fzfo/scripts"
while true; do cd "$SCRIPTDIR"; source $(ls "$SCRIPTDIR" | fzf); done
