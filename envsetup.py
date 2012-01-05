#!/usr/bin/env python

#Personal environment setup script
#Dependencies - Supported distros, sudo

import os
from subprocess import call
import platform
import urllib2

#global vars
vimrcurl = "https://raw.github.com/staticsafe/dotfiles/master/.vimrc"
zshrcurl = "https://raw.github.com/staticsafe/dotfiles/master/.zshrc"
tmuxurl = "https://raw.github.com/staticsafe/dotfiles/master/.tmux.conf"

def rootcheck():
	#rootcheck
	uid = os.getuid()
	if uid != 0:
		print 'This script must be run with sudo if you have it!'
		raise SystemExit
	else:
		print 'Root check: PASSED!'

def urldownload(confurl = ""):
	#Thanks PabloG from StackExchange for this little snippet - http://stackoverflow.com/a/22776
	url = confurl

	file_name = url.split('/')[-1]
	u = urllib2.urlopen(url)
	f = open(file_name, 'wb')
	meta = u.info()
	file_size = int(meta.getheaders("Content-Length")[0])
	print "Downloading: %s Bytes: %s" % (file_name, file_size)

	file_size_dl = 0
	block_sz = 8192

	while True:
		buffer = u.read(block_sz)
		if not buffer:
			break
		file_size_dl += len(buffer)
		f.write(buffer)
		status = r"%10d  [%3.2f%%]" % (file_size_dl, file_size_dl * 100. / file_size)
		status = status + chr(8)*(len(status)+1)
		print status,
	f.close()

def confdownload():
	urldownload(confurl = vimrcurl)
	urldownload(confurl = zshrcurl)
	urldownload(confurl = tmuxurl)


def envArch():
	#Install relevant packagtes
	installpackages  = call("sudo pacman --noconfirm -S vim zsh tmux git subversion", shell=True)

	#Get relevant dotfiles
	confdownload()

def envFedora():
	#Install relevant packages
	installpackages = call ("sudo yum install -y vim zsh tmux git subversion", shell=True)

	#Get relevant dotfiles
	confdownload()


def envDebian():
	#Install relevant packages
	installpackages = call ("sudo apt-get install --assume-yes vim zsh tmux git subversion", shell=True)

	#Get relevant dotfiles
	confdownload()

def main():
	#homedircheck
	homedir = os.environ['HOME']
	currentdir = os.getcwd()

	if currentdir != homedir:
		os.chdir(homedir)
	else:
		print "Home directory check : PASSED!"
	
	#distrocheck
	userdistro = platform.linux_distribution()

	if userdistro[0] == "Fedora":
		envFedora()
	elif userdistro[0] == "debian":
		envDebian()
	elif userdistro[0] == "Arch" or os.path.isfile("/etc/arch-release") == True:
		envArch()
	elif userdistro[0] == "Ubuntu":
		envDebian()
	else:
		print "This script is not supported for your distro, exiting."
		raise SystemExit

if __name__ == "__main__":
	main()