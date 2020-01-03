#!/bin/bash
scriptdir="$(dirname "$0")"
cd "$scriptdir"



#############################
# tmux config
#############################

# brew list tmux || echo "tmux is not installed"
# command -v tmux > /dev/null


if [ -x "$(command -v tmux)" ]; then
	echo "tmux is installed so let's add config."	
	cp ./.tmux.conf ~
	tmux source-file ~/.tmux.conf
else
	echo "tmux is not installed."
fi




cd $PWD

