#!/bin/bash

if ! [ "$UID" -eq 0 ]; then
    echo "You are not running as root. Please run this script with sudo or as root."
    exit 1
fi

if ! ping -c 1 github.com > /dev/null; then
    echo -e "You must have an internet connection!" && exit 1
fi


# Functions
errorlog() {
    echo -e "${RESEST}[${RED}${BLINK}ERROR${STOPBLINK}${RESEST}] $1" && sleep 0.2
}
warnlog() {
    echo -e "${RESET}[${YELLOW}WARN${RESET}] $1" && sleep 0.2
}
successlog() {
    echo -e "${RESET}[${GREEN}SUCCESS${RESET}] $1" && sleep 0.2
}
infolog() {
    echo -e "${RESET}[${CYAN}INFO${RESET}] $1" && sleep 0.2
}

# Function to determine the package manager and install a package
install_package() {
    local package=$1
    if command -v apt >/dev/null; then
        apt install -yq "$package" &> /dev/null
    elif command -v pacman >/dev/null; then
        pacman -S --noconfirm "$package" &> /dev/null
    else
        errorlog "No suitable package manager found. Please install $package manually."
        exit 1
    fi
}


check_and_install() {
    if ! command -v $1 >/dev/null; then
        infolog "Installing $2"
        install_package $2
        if ! command -v $1 >/dev/null; then
            errorlog "$2 installation failed, try manually."
            exit 1
        else
            successlog "$2 installed."
        fi
    else
        infolog "$2 found."
    fi
}

# Update package lists
apt update &> /dev/null
pacman -Syu --noconfirm &> /dev/null

! command -v curl >/dev/null && install_package install curl &> /dev/null

curl https://raw.githubusercontent.com/the-abra/func4bash/main/colors.lib -s -o /tmp/colors.lib
if [[ $(cat "/tmp/colors.lib" | head -n1) =~ "# Define color variables" ]]; then
    source "/tmp/colors.lib"
else
    errorlog "Colors not imported, you have to check github.com connection."
fi

# Check and install Git
check_and_install git git

# Move /lib/func4bash to /lib/func4bash.old if it exists
if [ -d /lib/func4bash ]; then
    [[ -d /lib/func4bash.old ]] && rm -r /lib/func4bash.old
    mv /lib/func4bash /lib/func4bash.old
    infolog "Moving /lib/func4bash to /lib/func4bash.old"
fi

cd /lib/
git clone https://github.com/the-abra/func4bash.git > /dev/null 2>&1
# Check if the clone was successful
if [ ! -d /lib/func4bash ]; then
    errorlog "System cloning process went wrong. \ncode: git clone https://github.com/the-abra/func4bash.git"
    exit 1
fi

[[ -f setup.sh ]] && rm setup.sh
rm /tmp/colors.lib

cd /lib/func4bash
git rm -r --cached . &> /dev/null

successlog "System files installed."
exit 0 
