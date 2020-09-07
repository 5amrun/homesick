#!/bin/zsh

##########################################
# List of tasks to be done:
#  - Installing Xcode-select without asking (prerequisite for HomeBrew)
#  - HomeBrew installation
#  - Python3 setup
#  - Shell config automation
#  - Installing apps
##########################################



chmod 775 ./utils.sh
source ./utils.sh


check_if_root()
{
	if [[ $(id -u) -ne 0 ]]; then
		echo "Please run as root!"
		exit 1
	fi
}

# HomeBrew:
ask_for_brew()
{
	while true; do
		
		read -p "Would you like to install HomeBrew using brew (y/n)?" ans
		
		if [[ "$ans" =~ ^[yY]$ ]]; then
			echo "Installing HomeBrew..."
			# Installing Xcode-select without asking (prerequisite for HomeBrew)
			if [[ $(xcode-select -v) =~ "xcode-select version" ]]; then
				echo "xcode-select is installed."
			else
				echo "xcode-select is not installed and trying to install..."
				xcode-select --install
			fi
			
			if ! [[ $(xcode-select -v) =~ "xcode-select version" ]]; then
				echo "xcode-select is not still installed....exiting..."
				exit 1
			fi
			echo "Trying to install Home-brew now..."
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
			break
		elif [[ "$ans" =~ ^[nN]$ ]]; then
			echo Skip installing HomeBrew...
			break
		else
			echo Please insert again:
		fi
	done
}


################################################################################

tput setaf 11 && echo echo "++++++++++ SS MacOS Initials Setup +++++++++" && tput sgr 0

check_if_root


echo "Checking if HomeBrew is installed..."

if [[ $(which brew) =~ "/usr/local/bin/brew" ]]; then
	echo "HomeBrew is installed."
else
	echo "HomeBrew is not installed."
	ask_for_brew
fi


tput setaf 11 && echo "--------------------------------------" && tput sgr 0
echo "Checking if Python3 is installed..."


chmod 775 ./python-setup/python_setup.sh
source ./python-setup/python_setup.sh

if [[ $(python3 -V) =~ "Python 3" ]]; then
	echo "Python $(python3 --version) is installed (It's automatically in HomeBrew installation) - which python3= $(which python3)"
	ask_for_python
	ask_for_python_stuff
else
	echo "Python3 not found by python3 --version."
	ask_for_python
	ask_for_python_stuff
fi

# This doesn't work since HomeBrew installs python3 in "/usr/local/bin/python3":
# if [[ -d "/Library/Frameworks/Python.framework/Versions" ]]; then
# 	echo "The directory exists: /Library/Frameworks/Python.framework/Versions/"
# 	echo "So skipping python3 installation (resolve python version by yourself if you want)."
# else
# 	echo "The directory does not exist: /Library/Frameworks/Python.framework/Versions/"
# 	ask_for_python
# fi


tput setaf 11 && echo "--------------------------------------" && tput sgr 0
echo "Beginning to work on shell configs..." 

print_in_box $(printenv)

# We won't check this way: if [[ -n "$ZSH_VERSION" ]]... because as sometimes it's bash but still...
if [[ "$SHELL" =~ "/bin/zsh" ]]; then
	echo "Z shell is being used - shell=${SHELL} - ZSH_VERSION=${ZSH_VERSION}"
	chmod 775 ./shell_config_utils.sh
	source ./shell_config_utils.sh
	configure_zsh
else
	print_in_box "Your shell (as root) is not zsh - shell=${SHELL} - $(dscl . -read /Users/root UserShell)" "Consider running: 'sudo dscl . -change /Users/root UserShell /bin/sh((your current)) /bin/zsh'"
	echo "[THIS PART NOT COMPLETE] Z shell is not installed or being used, it might be BASH - BASH_VERSION=${BASH_VERSION}"
fi


# Installing casks and leaves:
# Never run brew as root (they error out themselves)
#chmod 775 ./brew-install.sh
source ./brew/brew-install.sh
# sudo -u nobody zsh -c "source ./brew/brew-install.sh"


tput setaf 11 && echo "THE END" && tput sgr 0

