#!/bin/bash
scriptdir="$(dirname "$0")"
cd "$scriptdir"


echo "Begin brew installation..."


# If other brew process hasn't ended correctly
rm -rf /usr/local/var/homebrew/locks


brew update
brew cleanup


# Exporting what installed:
# brew leaves > leaves
# brew cask list > casks





# leaves:
while IFS= read -r line; do
		
	[ -z "$line" ] && continue # skip an empty str
	[[ ^[" "]$ =~ "$line" ]] && continue # skip spaces
	
	echo "Trying to install: $line"
	brew install $line

done < leaves.txt


# casks:
while IFS= read -r line; do
		
	[ -z "$line" ] && continue # skip an empty str
	[[ ^[" "]$ =~ "$line" ]] && continue # skip spaces
	
	echo "Trying to install: $line"
	brew cask install $line

done < casks.txt


cd $PWD

