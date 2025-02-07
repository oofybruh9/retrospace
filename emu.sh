#! /usr/bin/env bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

mainscr() {
    echo installing retroarch
    sudo flatpak install com.libretro.RetroArch
    cd /tmp/
    PS3='Browser?: '
    options=("Chrome" "Chromium" "Firefox" "Opera" "Vivaldi")
    select opt in "${options[@]}"
    do
        case $opt in
            "Chrome")
                wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
                sudo dpkg -i ./google-chrome-stable_current_amd64.deb
            ;;
            "Chromium")
                sudo flatpak install flathub org.chromium.Chromium
            ;;
            "Firefox")
                sudo flatpak install flathub org.mozilla.firefox
            ;;
            "Opera")
                sudo echo "deb http://deb.opera.com/opera/ stable non-free" >> '/etc/apt/sources.list.d/opera.list'
                sudo wget -O - http://deb.opera.com/archive.key | apt-key add -
                sudo apt update
                sudo apt install opera-stable
            ;;
            "Vivaldi")
                wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg
                echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" | sudo dd of=/etc/apt/sources.list.d/vivaldi-archive.list
                sudo apt update
                sudo apt install vivaldi-stable
            ;;
            *) echo -e "${Red}./setup.sh: err: $REPLY is not a valid browser option, please try again.";;
        esac
    done
}


FLATPAKCHECK="$(flatpak)"

if [[ -z $FLATPAKCHECK ]]; then
    echo -e "${Red}oops, looks like flatpak isnt installed! please make sure you've run setup.sh and if you did, check the logs and see why flatpak isnt installed."
else
    mainscr
fi