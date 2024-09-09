#!/bin/bash
# status indicators
greenplus='\e[1;33m[++]\e[0m'
redminus='\e[1;31m[--]\e[0m'

apt_update () {
        echo -e "\n $greenplus running: apt update \n"
        eval apt update -y
        echo -e "\n $greenplus running: apt update complete \n"
}

apt_upgrade() {
        echo -e "\n $greenplus running: apt dist-upgrade \n"
        eval apt -y dist-upgrade
        echo -e "\n $greenplus running: apt dist-upgrade complete \n"
}

install_terminator () {
        echo -e "\n $greenplus running: Installing terminator \n"
        eval sudo apt install terminator -y
        echo -e "\n $greenplus terminator installed -complete"
}

install_pimpmykali () {
        echo -e "\n $greenplus running: Cloning pimpmykali \n"
        PMK_REPO_URL="https://github.com/Dewalt-arch/pimpmykali.git"
	cd /opt
	sudo git clone "$PMK_REPO_URL"
	echo -e "\n $greenplus pimpmykali successfully cloned"
}

fix_rockyou () {
        echo -e "\n $greenplus running: Fixing rockyou \n"
	cd /usr/share/wordlists
	gzip -dqf /usr/share/wordlists/rockyou.txt.gz
	echo -e "\n $greenplus gunzip /usr/share/wordlists/rockyou.txt.gz"
}

install_seclists () {
        dpkg -s seclists &> /dev/null
        status=$?
        if [ $status -eq 0 ]; then
                echo -e "\n $redminus seclists already exist"
        else
                echo -e "\n $greenplus running: Installing seclists \n"
                sudo apt -y install seclists
                echo -e "\n $greenplus seclists successfully installed"
        fi
}

install_kaliwallpapers2023 () {
        dpkg -s kali-wallpapers-2023 &> /dev/null
        status=$?
        if [ $status -eq 0 ]; then
                echo -e "\n $redminus kali-wallpapers-2023 already exist"
        else
                echo -e "\n $greenplus running: Installing kaliwallpapers2023 \n"
                sudo apt -y install kali-wallpapers-2023
                echo -e "\n $greenplus kaliwallpapers successfully installed"
        fi
}

install_gobuster () {
        dpkg -s gobuster &> /dev/null
        status=$?
        if [ $status -eq 0 ]; then
                echo -e "\n $redminus gobuster already exist"
        else
                echo -e "\n $greenplus running: Installing gobuster \n"
                sudo apt -y install gobuster
                echo -e "\n $greenplus gobuster successfully installed"
        fi
}

install_gedit () {
        dpkg -s gedit &> /dev/null
        status=$?
        if [$status -eq 0]; then
                echo -e "\n $redminus gedit already installed"
        else
                echo -e "\n $greenplus running: Installing gedit \n"
                sudo apt -y install gedit
                echo -e "\n $greenplus gedit suceesfully installed"
        fi
}

install_netexec () {
        dpkg -s netexec &> /dev/null
        status=$?
        if [$status -eq 0]; then
                echo -e "\n $redminus netexec already installed"
        else
                echo -e "\n $greenplus running: Installing netexec \n"
                sudo apt -y install netexec
                echo -e "\n $greenplus netexec suceesfully installed"
        fi
}

apt_update
apt_upgrade
install_terminator
install_pimpmykali
fix_rockyou
install_seclists
install_kaliwallpapers2023
install_gobuster
install_gedit
install_netexec
