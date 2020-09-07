# config_shell.py

import sys
import os
import subprocess


WORKING_DIR = os.getcwd()



def check_if_exists():
	try:
		home_path = os.path.expanduser('~')
		os.chdir(home_path)
		command = 'ls -a | grep .zshrc'
		completed_process = subprocess.run(command.split(), stdout=subprocess.PIPE)
		print('Ran the command to see .zshrc exists or not - completed_process.stdout=' + str(completed_process.stdout))
		if completed_process.stdout:
			return True
		else:
			return False
	except Exception as e:
		print('Could not change path and check if config file exit (on you!): {0}'.format(e))
		exit_program(1)


def ask_overwrite():
	if check_if_exists():
		ans = input('The file ~/.zshrc already exists, should we overwrite (y/n)?')
		if ans == 'y':
			print('Ok, overwriting with new config...')
			return True
		elif ans == 'n':
			print('Ok, not overwriting the file...')
			return False
		else:
			print('Not a valid answer, try again...')
			return ask_overwrite()
	else:
		print('The file ~/.zshrc does not exists, creating a new file.')
		return True


def copy_shell_config_file():
	# careful to not be in home dir
	os.chdir(WORKING_DIR)
	os.system('cp -f -v ./.zshrc ' + os.path.expanduser('~') + '/.zshrc')


def exit_program(code):
	print(f'Exiting Python program - status_code={code} - file={__file__}')
	sys.exit(code)


def config_shell():
	if ask_overwrite():
		try:
			copy_shell_config_file()
		except Exception as e:
			print('Could not copy the config file: {0}'.format(e))
			exit_program(1)
	else:
		print('So you should take care of shell config manually.')
		exit_program(0)


if __name__ == '__main__':
	print('Python program is running - file=' + __file__)
	config_shell()


