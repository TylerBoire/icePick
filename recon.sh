#!/bin/bash
echo Welcome to icePick

function menu(){
	local choice = null
	echo Your options
	echo 1\) Information
	echo 2\) Escilation
	echo 3\) Reverse shells
	echo 4\) Covering Tracks
	read choice

	case $choice in
		1)
			Information
			;;
		2)
			Escilation
			;;
		3)
			shells
			;;
		4)
			hide
			;;
	esac
}

function Information() {
	echo Please enter the path you would like the output placed
	read path
	echo What would you like the output called\?
	read output

	touch $output

	#System
			cat /etc/shadow >> /$path/$output #shadow file with password hashes
			cat /etc/motd  >> /$path/$output #message of the day
			cat /etc/issue  >> /$path/$output #lists version of OS
			cat /etc/passwd  >> /$path/$output #lists user list. 
			uname -a  >> /$path/$output # Kernel version
			ps aux  >> /$path/$output #list all running processes
			id  >> /$path/$output #current usename and groups
			w  >> /$path/$output #who is connected
			last -a  >> /$path/$output #last users logged in
			dmesg  >> /$path/$output #information from last boot
			lsusb  >> /$path/$output #lists USB buses and devices
			df -k  >> /$path/$output #mounted filesystem and mount points
	#Network
			iptables -L -n -V >> /$path/$output #shows iptables in readable format
			cat /etc/resolv.conf >> /$path/$output 
			hostname -f  >> /$path/$output # lists hostname
			ip addr show  >> /$path/$output #lists ip address, new IFCONFIG
			route -n  >> /$path/$output #shows routing table
			cat /etc/network/interfaces  >> /$path/$output #lists interfaces
			netstat -anop  >> /$path/$output #shows connections
	#Users
			cat /etc/passwd	 >> /$path/$output #user list
			cat /etc/aliases  >> /$path/$output #lists aliases
	#Credentials
			/home/$USER/.ssh/id_rsa  >> /$path/$output #lists ssh keys
			cat /etc/crontab >> /$path/$output 
	#Installed packages
			rpm -qa --last |head  >> /$path/$output #red hat
			yum list |grep installed  >> /$path/$output #fedora
			dpkg -l  >> /$path/$output #debian
			pkg_info  >> /$path/$output #BSD
			pkginfo  >> /$path/$output #solaris
			pacman -Q  >> /$path/$output #arch
}
function Escilation(){
	sudo -l #shows the sudo files to indentify possible escilaitons.
}

menu