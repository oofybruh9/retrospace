#! /usr/bin/env bash
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
echo Setting up your retrospace
cd ~
mkdir apps
mkdir ES-DE
mkdir roms
cd apps
ln ~/ /workspaces/codespaces/Home/
echo installing es-de
wget https://gitlab.com/es-de/emulationstation-de/-/package_files/164503027/download
chmod +x ES-DE_x64.AppImage
echo done installing ES-DE

echo "installing bauh (app manager)"
pip install bauh
echo done installing bauh

echo installing flatpak
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo done installing flatpak

echo installing wine
sudo dpkg --add-architecture i386
verwinw=$(cat /etc/os-release | sed -n 's/^VERSION_CODENAME=//p')
winos=$(cat /etc/os-release | sed -n 's/^ID=//p')
sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/${winos}/dists/${verwinw}/winehq-${verwinw}.sources

echo "done! please stop the codespace and start it again and then run emu.sh for the rest of the setup!"