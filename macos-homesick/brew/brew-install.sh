#!/bin/zsh
# To be run from macos_initials.sh (due to path complications)


echo "Begin brew installation..."


chmod 775 ./utils.sh
source ./utils.sh



#scriptdir="$(dirname "$0")"
#echo "Changing dir - scriptdir=${scriptdir}"
#cd "$scriptdir"



# If other brew process hasn't ended correctly
rm -rf /usr/local/var/homebrew/locks


sudo -u $SUDO_USER zsh -c "brew update"

# Will remove outdated installed package versions:
sudo -u $SUDO_USER zsh -c "brew cleanup"



# leaves:
while IFS= read -r line; do
	
	[ -z "$line" ] && continue # skip an empty str
	[[ ^[" "]$ =~ "$line" ]] && continue # skip spaces
	
	echo "Trying to install: $line"
	sudo -u $SUDO_USER zsh -c "brew install $line"
	# brew install $line

done < ./brew/leaves.txt


# casks:
while IFS= read -r line; do
	
	[ -z "$line" ] && continue # skip an empty str
	[[ ^[" "]$ =~ "$line" ]] && continue # skip spaces
	
	echo "Trying to install: $line"
	sudo -u saman zsh -c "brew cask install $line"
	# brew cask install $line

done < ./brew/casks.txt



#cd $PWD


# ------------------------------------------------------

# Exporting what installed:
# brew leaves > leaves
# brew cask list > casks


print_in_box "++++ brew leaves ++++" "" $(sudo -u $SUDO_USER zsh -c "brew leaves")

print_in_box "++++ brew cask list ++++" "" $(sudo -u $SUDO_USER zsh -c "brew cask list")



tput setaf 11 && echo "THE END OF INSTALATIONS" && tput sgr 0


