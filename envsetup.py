#!/usr/bin/env python

#Personal environment setup script
#Dependencies - Supported distros, sudo, python2

import os
from subprocess import call
import platform
import urllib2

#global vars
vimrcurl = "https://raw.github.com/staticsafe/dotfiles/master/.vimrc"
zshrcurl = "https://raw.github.com/staticsafe/dotfiles/master/.zshrc"
tmuxurl = "https://raw.github.com/staticsafe/dotfiles/master/.tmux.conf"
vimdirurl = "https://github.com/staticsafe/dotfiles/raw/master/vimdir.tar.bz2"

def sudocheck():
	#sudocheck
	sudopath = "/usr/bin/sudo"
	if os.path.isfile(sudopath) == True:
		print 'This script needs sudo to run!'
		raise SystemExit
	else:
		print 'Sudo check: PASSED!'

def urldownload(confurl = ""):
	#Thanks PabloG from StackOverflow for this little snippet - http://stackoverflow.com/a/22776
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

def checksandactions():
	#vars for various conf files and dirs
	vimrcdir = os.path.join(os.environ['HOME'], ".vimrc")
	zshrcdir = os.path.join(os.environ['HOME'], ".zshrc")
	tmuxconfdir = os.path.join(os.environ['HOME'], ".tmux.conf")
	vimdir = os.path.join(os.environ['HOME'], ".vim")
	usershell = os.getenv('SHELL')
	
	#checks to prevent clobbering
	if os.path.isfile(vimrcdir) == True:
		print ".vimrc already exists, skipping download!"
	else:
		urldownload(confurl = vimrcurl)
	
	if os.path.isfile(zshrcdir) == True:
		print ".zshrc already exists, skipping download!"
	else:
		urldownload(confurl = zshrcurl)
	
	if os.path.isfile(tmuxconfdir) == True:
		print ".tmux.conf already exists, skipping download!"
	else:
		urldownload(confurl = tmuxurl)
	
	if os.path.isdir(vimdir) == True:
		print ".vim dir already exists, skipping download!"
	else:
		urldownload(confurl = vimdirurl)
		untar = call("tar xvf vimdir.tar.bz2", shell = True)
	
	if usershell == "/bin/zsh":
		print "Your default shell is already zsh! Skipping."
	else:
		print "Setting default shell for this user to zsh! Log out and log back in to see changes."
		setzsh = call("chsh -s $(which zsh)", shell = True)
		zshhistory = call("touch ~/.zshistory", shell = True)

def envArch():
	sudocheck()
	#Install relevant packages
	installpackages  = call("sudo pacman --noconfirm -S vim zsh tmux git subversion", shell=True)

	#Get relevant dotfiles
	checksandactions()

def envFedora():
	sudocheck()
	#Install relevant packages
	installpackages = call ("sudo yum install -y vim zsh tmux git subversion", shell=True)

	#Get relevant dotfiles
	checksandactions()

def envDebian():
	sudocheck()
	#Install relevant packages
	installpackages = call ("sudo apt-get install --assume-yes vim zsh tmux git subversion", shell=True)

	#Get relevant dotfiles
	checksandactions()

def main():
	#homedircheck
	homedir = os.environ['HOME']
	currentdir = os.getcwd()

	if currentdir != homedir:
		print "Changing cwd to homedir!"
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