# Scripts used to setup a fresh debian installation
DEBIAN_CODENAME := $(shell lsb_release -a | grep "Codename:" | sed -En "s/^.*\s//p")
USER_HOME = /home/greg

setup/system:
	sed -i '/cdrom/d' /etc/apt/sources.list
	sed -i.bak 's/${DEBIAN_CODENAME}/testing/' /etc/apt/sources.list
	apt update
	apt upgrade -y
	apt install -y \
		sudo \
		xorg \
		xinit \
		i3 \
		suckless-tools \
		lightdm \
		network-manager \
		network-manager-gnome \
		pulseaudio \
		pasystray \
		pavucontrol \
		fonts-noto \
		fonts-hack-ttf \
		dunst \
		fish \
		rcm \
		ripgrep \
		firefox-esr \
		printer-driver-all \
		cups \
		ipp-usb \
		tlp tlp-rdw
	dpkg-reconfigure lightdm
	sed -i -e '$$auser-session=i3' /usr/share/lightdm/lightdm.conf.d/01_debian.conf
	touch $(USER_HOME)/.xsession
	echo 'setxkbmap -option caps:escape' >> $(USER_HOME)/.xsession
	echo 'exec i3' >> $(USER_HOME)/.xsession

setup/user:
	sudo adduser greg sudo;
	apt install -y \
	su greg
	chsh -s $(which fish)
	git clone https://github.com/gnfisher/linux_dotfiles.git /home/greg/dotfiles
	env RCRC=$(USER_HOME)/dotfiles/rcrc rcup
