#!/bin/zsh


brew_install_python3()
{	
	brew update
	echo "brew list:::"
	brew list
	found = $(brew list | grep -q python) # if found result is 0!
	if ! [[ ${found} ]]; then
		echo "Trying to reinstall python3..."
		brew reinstall python3
	else
		echo "Trying to install python3..."
		brew install python3
	fi
	echo "brew list | grep python:::"
	brew list | grep python
}


ask_for_python()
{
	while true; do
		
		read -p "Would you like to install/upgrade Python3 using brew (y/n)?" ans
		
		if [[ "$ans" =~ ^[yY]$ ]]; then
			echo "Installing Python3..."
			brew_install_python3
			break
		elif [[ "$ans" =~ ^[nN]$ ]]; then
			echo Skip installing Python3...
			break
		else
			echo Please insert again:
		fi
	done
}


setup_python3_stuff()
{
    # Setuptools can be updated via pip3, without having to re-brew Python:
    python3 -m pip install --upgrade setuptools
    # Similarly, pip3 can be used to upgrade itself via:
    python3 -m pip install --upgrade pip

	pip3 install -r ./python-setup/requirements.txt
}


ask_for_python_stuff()
{
	while true; do
		
		read -p "Would you like to upgrade/setup Python3 stuff...setup-tools upgrade...basic packages...(y/n)?" ans
		
		if [[ "$ans" =~ ^[yY]$ ]]; then
			setup_python3_stuff
			break
		elif [[ "$ans" =~ ^[nN]$ ]]; then
			echo Skip Python3 setup...
			break
		else
			echo Please insert again:
		fi
	done
}

