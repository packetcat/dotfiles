#!/usr/bin/env python

#Personal environment setup script

import os
from subprocess import call
import platform
import re
import urllib2

#global vars
vimrcurl = "https://raw.github.com/staticsafe/dotfiles/master/.vimrc"
zshrcurl = "https://raw.github.com/staticsafe/dotfiles/master/.zshrc"
tmuxurl = "https://raw.github.com/staticsafe/dotfiles/master/.tmux.conf"

def rootcheck():
	#rootcheck
	uid = os.getuid()
	if uid != 0:
		print 'This script must be run as root or sudo if you have it!'
		raise SystemExit

def main():
	#homedircheck
	homedir = os.environ['HOME']
	currentdir = os.getcwd()

	if currentdir != homedir:
		os.chdir(homedir)
	else:
		print "Home directory check : PASSED!'"
	#distrocheck
	userdistro = platform.linux_distribution()

	if userdistro[0] == "Fedora":

	elif userdistro[0] == "debian":

	elif userdistro[0] == "Arch" or os.path.isfile("/etc/arch-release") == True:

	elif userdistro[0] == "Ubuntu":

	else:
		print "This script is not supported for your distro, exiting."
		raise SystemExit

if __name__ == "__main__":
	main()