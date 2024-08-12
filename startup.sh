#!/bin/bash

# status indicators
greenplus='\e[1;33m[++]\e[0m'
redminus='\e[1;31m[--]\e[0m'

DIR="/opt"


apt_update () {
    echo -e "\n $greenplus running: apt update \n"
    eval apt update -y
}

apt_upgrade() {
    echo -e "\n  $greenplus running: apt upgrade \n"
    eval apt -y upgrade
}

apt_autoremove() {
    echo -e "\n  $greenplus running: apt autoremove \n"
    eval apt -y autoremove
}

apt_update_complete() {
    echo -e "\n  $greenplus apt update - complete"
}

apt_upgrade_complete() {
    echo -e "\n  $greenplus apt upgrade - complete"
}

apt_autoremove_complete() {
    echo -e "\n  $greenplus apt autoremove - complete"
}

install_terminator () {
    echo -e "\n  $greenplus running: Installing terminator \n"
    eval sudo apt install terminator -y
    echo -e "\n  $greenplus terminator installed -complete"
}

check_opt () {
    if [ ! -d "$DIR" ]; then
        echo -e "\n $greenplus $DIR directory does not exist. Creating it now..."
        sudo mkdir -p "$DIR"
        if [ $? -eq 0]; then
            echo -e "\n $greenplus Directory $DIR successfully created"
        else
            echo -e "\n $redminus Failed to create directory $DIR." >&2
            exit 1
        fi
    else
        echo -e "\n $greenplus Directory $DIR already exists"
    fi
}

install_pimpmykali () {
PMK_REPO_URL="https://github.com/Dewalt-arch/pimpmykali.git"
PMK_DIR="/opt/pimpmykali"
    if [ -d "$PMK_DIR" ]; then
        echo -e "\n $redminus $PMK_DIR already exists. Skipping clone"
    else
        echo -e "\n $greenplus Cloning the pimpmykali repository into $PMK_DIR..."
        sudo git clone "$PMK_REPO_URL" "$PMK_DIR"
        if [ $> -eq 0]; then
            echo -e "\n $greenplus pimpmykali successfully cloned"
        else
            echo -e "\n $redminus Failed to clone pimpmykali repository." >&2
            exit 1
        fi
    fi
}

fix_rockyou () {
WORDLIST_DIR="/usr/share/wordlists"
ROCKYOU_ARCHIVE="$WORDLIST_DIR/rockyou.txt.gz"
ROCKYOU_FILE="$WORDLIST_DIR/rockyou.txt"

# Check if the rockyou.txt.gz archive exists
if [ -f "$ROCKYOU_ARCHIVE" ]; then
    echo -e "\n $greenplus rockyou.txt.gz archive found."

    # Check if rockyou.txt already exists
    if [ -f "$ROCKYOU_FILE" ]; then
        echo -e "\n $greenplus rockyou.txt is already unzipped."
    else
        # Unzip the rockyou.txt.gz archive
        echo -e "\n $greenplus Unzipping rockyou.txt.gz..."
        sudo gzip -dq "$ROCKYOU_ARCHIVE"
        if [ $? -eq 0 ]; then
            echo -e "\n $greenplus Finished unzipping rockyou.txt."
        else
            echo -e "\n $redminus Failed to unzip rockyou.txt.gz." >&2
            exit 1
        fi
    fi
else
    echo -e "\n $redminus rockyou.txt.gz archive not found in $WORDLIST_DIR." >&2
fi
}

install_seclists () {
    dpkg -s seclists &> /dev/null
    status=$?
    if [ $status -eq 0 ]; then
        echo -e "\n $greenplus seclists already exist"
    else
        sudo apt -y install seclists
    fi
}

install_kaliwallpapers2023 () {
    dpkg -s kali-wallpapers-2023 &> /dev/null
    status=$?
    if [ $status -eq 0 ]; then
        echo -e "\n $greenplus kali-wallpapers-2023 already exist"
    else
        sudo apt -y install kali-wallpapers-2023
    fi
}

install_gobuster () {
    dpkg -s gobuster &> /dev/null
    status=$?
    if [ $status -eq 0 ]; then
        echo -e "\n $greenplus gobuster already exist"
    else
        sudo apt -y install gobuster
        echo -e "\n $greenplus gobuster successfully installed"
    fi
}

apt_update
apt_upgrade
apt_autoremove
apt_update_complete
apt_upgrade_complete
apt_autoremove_complete

install_terminator

check_opt
install_pimpmykali
fix_rockyou
install_seclists
install_kaliwallpapers2023
install_gobuster