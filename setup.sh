#! /usr/bin/env bash
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Yellow='\033[0;33m'       # Yellow
echo Setting up your retrospace
sudo apt update
cd ~
mkdir apps
mkdir ES-DE
mkdir roms
mkdir ~/daicons/
cd apps
ln -S ~ /workspaces/codespaces/Home/
echo installing es-de
curl https://gitlab.com/es-de/emulationstation-de/-/package_files/164503027/download -o ES-DE_x64.AppImage
./ES-DE_x64.AppImage --extract-appimage
mv squashfs-root es-de
curl https://impro.usercontent.one/appid/oneComWsb/domain/es-de.org/media/es-de.org/onewebmedia/ES-DE_logo.png -o ~/daicons/es-de.png
echo done installing ES-DE

echo "installing bauh (app manager)"
pip install bauh
sudo apt install aptitude
curl https://oofybruh9.rf.gd/wp-content/uploads/2025/02/Manage-AppImages-AUR-Flatpaks-And-Snaps-With-Bauh-In-Linux-1.png -o ~/daicons/bauh.png
echo done installing bauh

echo installing flatpak
sudo apt install flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo done installing flatpak

echo installing wine
sudo dpkg --add-architecture i386
verwinw=$(cat /etc/os-release | sed -n 's/^VERSION_CODENAME=//p')
winos=$(cat /etc/os-release | sed -n 's/^ID=//p')
sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/${winos}/dists/${verwinw}/winehq-${verwinw}.sources

echo "installing idesk (for app icons on desktop)"
sudo apt install idesk
touch ~/.ideskrc
cat >~/.ideskrc <<EOL
table Config
  FontName: tahoma
  FontSize: 8
  FontColor: #ffffff
  Locked: false
  Transparency: 150
  HighContrast: true
  Shadow: true 
  ShadowColor: #000000
  ShadowX: 1
  ShadowY: 2
  Bold: false
  ClickDelay: 300
  IconSnap: true
  SnapWidth: 32 
  SnapHeight: 32
  SnapOrigin: BottomRight
  SnapShadow: true
  SnapShadowTrans: 200
  CaptionOnHover: false
end
table Actions
  Lock: control right doubleClk
  Reload: middle doubleClk
  Drag: left hold
  EndDrag: left singleClk
  Execute[0]: left doubleClk
  Execute[1]: right doubleClk
end
EOL
mkdir ~/.idesktop
touch ~/.idesktop/ES-DE.lnk
cat >~/.idesktop/ES-DE.lnk <<EOL
table Icon
  Caption: ES-DE
  Command: ~/apps/es-de/AppRun
  Icon: ~/daicons/es-de.png
  Width: 32
  Height: 32
  X: 32
  Y: 32
end
EOL
touch ~/.idesktop/bauh.lnk
cat >~/.idesktop/bauh.lnk <<EOL
table Icon
  Caption: bauh
  Command: bauh
  Icon: ~/daicons/bauh.png
  Width: 32
  Height: 32
  X: 32
  Y: 32
end
EOL


echo "done! please stop the codespace and start it again and then run emu.sh for the rest of the setup!"
echo -e "${Yellow}NOTE: you NEED to extract AppImages by running ./app.appimage --extract-appimage because fuse doesn't work."