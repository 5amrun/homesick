
echo Setting up...





# Python:
ask_for_python()
{
	while true; do
		
		read -p "Would you like to install Python using brew (y/n)?" ans
		
		if [[ "$ans" =~ ^[yY]$ ]]; then
			echo "Installing Python... (Not installing because it's not complete)"
			break
		elif [[ "$ans" =~ ^[nN]$ ]]; then
			echo Skip installing Python...
			break
		else
			echo Please insert again.
		fi

	done
}



if [[ $(python3 -V) =~ "Python 3" ]]; then
    echo Python 3 is installed
else
    echo Python 3 is not installed
	ask_for_python
fi



# installing casks and leaves:
# maybe need to chmod here...
sudo chmod 770 ./brew/brew-install.sh 
source ./brew/brew-install.sh










echo THE END

