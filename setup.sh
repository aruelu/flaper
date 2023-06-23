#!/bin/bash

DIRBIN=$HOME/.local/myflatpak

if type apt &> /dev/null
then
    sudo apt update
    package_command="apt install -y"

elif type yum &> /dev/null
then
    package_command="yum install -y"

elif type pacman &> /dev/null
then
    sudo pacman -Syy
    package_command="pacman -S"

elif type zypper &> /dev/null
then
    if cat /etc/os-release | grep "openSUSE Tumbleweed" &> /dev/null
    then
        remo_name="https://download.opensuse.org/repositories/GNOME:Apps/openSUSE_Factory+GNOME_Factory/GNOME:Apps.repo"
    elif cat /etc/os-release | grep "openSUSE Leap 15.5" &> /dev/null
    then
        repo_name="https://download.opensuse.org/repositories/GNOME:Apps/15.5/GNOME:Apps.repo"
    elif cat /etc/os-release | grep "openSUSE Leap 15.4" &> /dev/null
    then
        repo_name="https://download.opensuse.org/repositories/GNOME:Apps/15.4/GNOME:Apps.repo"
    else
        echo "対応していないSUSEです"
        exit 2
    fi
    sudo zypper addrepo "$repo_name"
    sudo zypper refresh
    package_command="zypper --non-interactive in"

else
    echo "サポートされているパッケージマネージャが無いため終了します！"
    exit 1

fi

echo "パッケージマネージャのコマンド：""$package_command"
sudo $package_command yad
sudo $package_command flatpak
sudo $package_command gnome-software-plugin-flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
if [ ! -d $DIRBIN ]
then
    mkdir $DIRBIN
fi

yad --title="お願い" --text="設定を反映されるためには、再起動が必要です"
