#!/bin/bash

##
## A script I made to simplify the setup of Arch installations to my liking.
## Author: Jan Ove Saltvedt
## Warning: Expect that this script is broken, it is not really tested!
##
## Before running this script the following should be installed:
##  - sudo
##  - git
##  - a video driver
##


pushd `dirname $0` > /dev/null
BASE=`pwd -P`
FS=$BASE/fs
popd > /dev/null

USER=`id -n -u`
GROUP=`id -n -g`

read -r -p "Ask for confirmation on every line? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  # Hacky way to run line by line with stepping
  shopt -s extdebug
  trap '
    read -n1 -p "run \"$BASH_COMMAND\"? " answer <> /dev/tty 1>&0
    echo > /dev/tty
    [[ $answer = [yY] ]]' DEBUG

fi


##
## Install dependencies for the script itself
##

read -r -p "Install pacaur? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  # Install pacaur's dependency Cower
  pushd /tmp
  git clone https://aur.archlinux.org/cower.git cower
  cd cower
  makepkg -si
  cd ..
  rm -rf cower
  popd

  # Install pacaur
  pushd /tmp
  git clone https://aur.archlinux.org/pacaur.git pacaur
  cd pacaur
  makepkg -si
  cd ..
  rm -rf pacaur
  popd

else

  echo "Some packages installed later is only found on AUR. This choice will cause errors"

fi


##
## Secure all the stuff
##
echo "~~~Security section~~~"

read -r -p "Add default restrictive iptables rules? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  # Iptables
  sudo cp $FS/etc/iptables/iptables.rules /etc/iptables/iptables.rules
  sudo systemctl enable iptables
  sudo systemctl restart iptables
  sudo cp $FS/etc/iptables/ip6tables.rules /etc/iptables/ip6tables.rules
  sudo systemctl enable ip6tables
  sudo systemctl restart ip6tables

fi

read -r -p "Install openvpn? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  # Install openvpn
  sudo pacman -S openvpn
  
  echo "Add configs manually to /etc/openvpn/"

fi

##
## Install a proper shell and cli utilities
##
echo "~~~CLI section~~~"

read -r -p "Install zsh? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  sudo pacman -S zsh zsh-syntax-highlighting
  cp $FS/home/user/.zshrc $HOME/
  cp $FS/home/user/.zprofile $HOME/
  chsh /bin/zsh

fi

### 
### Install vim with proper extensions
###
read -r -p "Install vim? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  sudo pacman -S vim
  cp $FS/home/user/.vimrc $HOME
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall

else

  echo "WHAT rly?"

fi

##
## Install nice to have CLI utilities
##

read -r -p "Install unzip ranger htop nmon powertop bind-tools wget? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  sudo pacman -S unzip ranger htop nmon powertop bind-tools wget

fi

##
## Install visual stuff
##
echo "~~~GUI section~~~"

read -r -p "Install xorg server++? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  # Install xorg
  sudo pacman -S xorg-server xorg-server-utils xorg-xev xorg-xfontsel  xorg-xinit

fi

read -r -p "Install i3++? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  # Install i3
  sudo pacman -S i3-wm i3status i3lock dunst xautolock deepin-screenshot
  cp $FS/home/user/.xinitrc $HOME/
  chmod +x $HOME/.xinitrc
  cp $FS/home/user/.Xdefaults $HOME/
  mkdir -p $HOME/.config/i3
  cp $FS/home/user/.config/i3/config $HOME/.config/i3/
  mkdir -p $HOME/.config/i3status
  cp $FS/home/user/.config/i3status/i3status.conf $HOME/.config/i3status/
  mkdir -p $HOME/.config/i3lock
  cp $FS/home/user/.config/i3lock/wallpaper.png $HOME/.config/i3status/
  mkdir -p $HOME/.config/Deepin
  cp "$FS/home/user/.config/Deepin/Deepin Screenshot.conf" $HOME/.config/Deepin/

  sudo pacman -S rxvt-unicode terminus-font
  pacaur -S terminess-powerline-font-git
  pacaur -S j4-dmenu-desktop

fi

read -r -p "Run 'xautolock -locknow' on suspend? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  sudo cp $FS/etc/systemd/system/suspend-lock.service /etc/systemd/system/suspend-lock.service 
  sudo systemctl enable suspend-lock.service

fi

read -r -p "Install chromium? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  sudo pacman -S chromium

fi

###
### Install offline copy of arch wiki. 
###
echo "~~~Random section~~~"

read -r -p "Install offline arch wiki? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then

  sudo pacman -S arch-wiki-docs

else

  echo "You will probably regret that decision some day..."

fi
