#!/bin/sh
sudo apt update -y
sudo apt upgrade -y
sudo apt install snapd git -y
sudo apt install curl gnome-tweaks -y

curl -LO https://vscode.download.prss.microsoft.com/dbazure/download/stable/863d2581ecda6849923a2118d93a088b0745d9d6/code_1.87.2-1709912201_amd64.deb
sleep 2
sudo chmod +x code_1.87.2-1709912201_amd64.deb
sudo dpkg -i code_1.87.2-1709912201_amd64.deb

curl -LO https://github.com/sqlectron/sqlectron-gui/releases/download/v1.38.0/sqlectron_1.38.0_amd64.deb
sleep 2
sudo chmod +x sqlectron_1.38.0_amd64.deb
sudo dpkg -i sqlectron_1.38.0_amd64.deb

curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sleep 2
sudo chmod +x google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf --output meslo.ttf
mkdir ~/.fonts
mv *.ttf ~/.fonts
fc-cache -f -v
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme/  &&  ./install.sh -N mojave

git clone https://github.com/vinceliuice/McMojave-circle.git
cd McMojave-circle/ &&./install.sh
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Light"
gsettings set org.gnome.desktop.interface icon-theme "McMojave-circle-dark"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F \'/\' '{print $NF}')/ font "Meslo LG M Regular for Powerline 12"
