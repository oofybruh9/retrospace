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
echo installing emulationstation
git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
cd RetroPie-Setup
sudo ./retropie_setup.sh
curl https://impro.usercontent.one/appid/oneComWsb/domain/es-de.org/media/es-de.org/onewebmedia/ES-DE_logo.png -o ~/daicons/es-de.png
echo done installing emulationstation

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

echo done installing idesk

echo installing java and rust
sudo apt install default-jdk
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo done installing java and rust

echo installing mpv
sudo curl --output-dir /etc/apt/trusted.gpg.d -O https://apt.fruit.je/fruit.gpg
sudo touch /etc/apt/sources.list.d/fruit.list
cat >/etc/apt/sources.list.d/fruit.list <<EOL
deb http://apt.fruit.je/ubuntu noble mpv
EOL
sudo apt update
sudo apt install mpv
echo done installing mpv

echo installing audio support
sudo echo "load-module module-simple-protocol-tcp listen=127.0.0.1 format=s16le channels=2 rate=48000 record=true playback=false" > /etc/pulse/default.pa.d/simple-protocol.pa
echo 'pulseaudio -k &' >> ~/.fluxbox/init
echo 'pulseaudio --start &' >> ~/.fluxbox/init
curl https://raw.githubusercontent.com/me-asri/noVNC-audio-plugin/refs/heads/main/audio-plugin.js -o /usr/local/novnc/noVNC-1.2.0/audio-plugin.js
wget https://raw.githubusercontent.com/me-asri/noVNC-audio-plugin/refs/heads/main/audio-proxy.sh
sudo apt install socat gstreamer1.0-tools gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad
sudo mkdir /etc/websockify/
sudo touch /etc/websockify/token.cfg
sudo cat > /etc/websockify/token.cfg << EOF
	audio: 127.0.0.1:5711
EOF
echo -e "${Yellow}please edit /usr/local/novnc/noVNC-1.2.0/utils/launch.sh on line 165 and replace this:"
echo '${WEBSOCKIFY} ${SSLONLY} --web ${WEB} ${CERT:+--cert ${CERT}} ${KEY:+--key ${KEY}} ${PORT} ${VNC_DEST} ${RECORD_ARG} &'
echo -e "${Yellow}for this:"
echo '${WEBSOCKIFY} ${SSLONLY} --web ${WEB} ${CERT:+--cert ${CERT}} ${KEY:+--key ${KEY}} ${PORT} ${VNC_DEST} ${RECORD_ARG} --token-plugin=TokenFile --token-source=/etc/websockify/token.cfg &'
echo -e "${Yellow}cuz this script cant do that."

echo -e "${Color_Off}done! please stop the codespace and start it again and then run emu.sh for the rest of the setup!"
echo -e "${Yellow}NOTE: you NEED to extract AppImages by running ./app.appimage --extract-appimage because fuse doesn't work."