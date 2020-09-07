
echo "Loading source: shell_config_utils.sh"


configure_zsh()
{
	echo "Starting to configure zsh..."
	python3 "./pyscripts/config_shell.py"
	# echo "The py script returned status_code - code=${status_code}"
}




