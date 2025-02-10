#! /usr/bin/env bash

: <<'END_COMMENT'
This file is part of retrospace.

retrospace is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

retrospace is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with retrospace. If not, see <https://www.gnu.org/licenses/>.
END_COMMENT


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
    sudo flatpak install org.libretro.RetroArch
    curl https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Retroarch.svg/2048px-Retroarch.svg.png -o ~/daicons/retroarch.png
    echo done installing retroarch
    cd /tmp/
    PS3='Browser?: '
    options=("Chrome" "Chromium" "Firefox" "Opera" "Vivaldi")
    select opt in "${options[@]}"
    do
        case $opt in
            "Chrome")
                sudo flatpak install flathub com.google.Chrome
                curl https://raw.githubusercontent.com/alrra/browser-logos/refs/heads/main/src/chrome/chrome.png -o ~/daicons/chrome.png
                break
            ;;
            "Chromium")
                sudo flatpak install flathub org.chromium.Chromium
                curl https://raw.githubusercontent.com/alrra/browser-logos/refs/heads/main/src/chromium/chromium.png -o ~/daicons/chromium.png
                break
            ;;
            "Firefox")
                sudo flatpak install flathub org.mozilla.firefox
                curl https://raw.githubusercontent.com/alrra/browser-logos/refs/heads/main/src/firefox/firefox.png -o ~/daicons/firefox.png
                break
            ;;
            "Opera")
                sudo flatpak install flathub com.opera.Opera
                curl https://raw.githubusercontent.com/alrra/browser-logos/refs/heads/main/src/opera/opera.png -o ~/daicons/opera.png
                break
            ;;
            "Vivaldi")
                sudo flatpak install flathub org.vivaldi.Vivaldi
                curl https://raw.githubusercontent.com/alrra/browser-logos/refs/heads/main/src/vivaldi/vivaldi.png -o ~/daicons/vivaldi.png
                break
            ;;
            *) echo -e "${Red}./emu.sh: err: $REPLY is not a valid browser, please try again.";;
        esac
    done
}


FLATPAKCHECK="$(flatpak --help)"

if [[ -z $FLATPAKCHECK ]]; then
    echo -e "${Red}oops, looks like flatpak isnt installed! please make sure you've run setup.sh and if you did, check the logs and see why flatpak isnt installed."
else
    mainscr
fi
