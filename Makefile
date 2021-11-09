# Scripts used to setup a fresh debian installation
DEBIAN_CODENAME := $(shell lsb_release -a | grep "Codename:" | sed -En "s/^.*\s//p")
I3_GAPS_REPO = https://www.github.com/Airblader/i3
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
		suckless-tools \
		i3status \
		lightdm
	apt install -y dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev
	apt install -y python3 python3-pip python3-setuptools \
                       python3-wheel ninja-build meson
	git clone $(I3_GAPS_REPO) $(USER_HOME)/i3-gaps
	mkdir $(USER_HOME)/build
	meson --prefix /usr/local $(USER_HOME)/i3-gaps $(USER_HOME)/build
	ninja install -C $(USER_HOME)/build
	dpkg-reconfigure lightdm
	sed -i -e '$$auser-session=i3' /usr/share/lightdm/lightdm.conf.d/01_debian.conf
	touch $(USER_HOME)/.xsession
	echo 'setxkbmap -option caps:escape
	exec i3' >> $(USER_HOME)/.xsession

setup/user:
	sudo adduser greg sudo;
