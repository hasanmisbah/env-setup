#!/bin/bash

scriptName='Apps Installer'


# Regular Colors
Color_Off='\033[0m'       # Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan


checkRoot(){
    #Check if running as root  
    if [ "$(id -u)" != "0" ]; then  
        echo  "\n${Yellow} This script must be run as root ${Color_Off}" 
        echo  "${Blue} Try sudo su ${Color_Off} or ${Cyan} sudo sh ${scriptName}" 
        echo  "" 1>&2 
        exit 1  
    fi
}

update(){
    echo  "${Purple} * Updating package repositories...${Color_Off}"
    sudo apt -qq update
    echo  "\n${Green} * Package Successfully Updated ${Color_Off}"
}

upgrade(){
    echo  "\n${Purple} * Upgrading all installed package...${Color_Off}"
    sudo apt -qq upgrade -y
    echo  "\n${Green} * Package Successfully Upgraded ${Color_Off}"
}

installBasic(){
    echo  "\n${Purple} * installing [install ubuntu-restricted-extras vlc wget curl]...${Color_Off}"
    sudo apt -qq install ubuntu-restricted-extras vlc wget curl
    echo  "\n${Green} * Package [ubuntu-restricted-extras, vlc, wget, curl] Successfully Installed ${Color_Off}"
}

installPhp(){

    echo  "\n${Purple} * installing [software-properties-common]...${Color_Off}"
    sudo apt -qq install software-properties-common -y
    echo  "\n${Green} * Package [software-properties-common] Successfully Installed ${Color_Off}"

    echo  "\n${Purple} * Adding Repository [ppa:ondrej/php]...${Color_Off}"
    sudo add-apt-repository -y ppa:ondrej/php
    update

    echo  "\n${Purple} * installing [php8.0 php8.0-fpm php8.0-mysql libapache2-mod-php8.0 libapache2-mod-fcgid]...${Color_Off}"
    sudo apt -qq install php8.0 php8.0-fpm php8.0-mysql libapache2-mod-php8.0 libapache2-mod-fcgid -y
    echo  "\n${Green} * Package [php8.0 php8.0-fpm php8.0-mysql libapache2-mod-php8.0 libapache2-mod-fcgid] Successfully Installed ${Color_Off}"
}

installMysql(){

    echo  "\n${Purple} * installing [mysql-server]...${Color_Off}"
    sudo apt install mysql-server mysql-client -y
    echo  "\n${Green} * Package [mysql-server] Successfully Installed ${Color_Off}"
    
    echo  "\n${Purple} * configuring mysql...${Color_Off}"
    sudo /etc/init.d/mysql start
    sudo mysql_secure_installation
    echo  "\n${Purple} * MySql Configuration Done...${Color_Off}"
}

laravelPackage(){

    echo  "\n${Purple} * installing [network-manager libnss3-tools jq xsel]...${Color_Off}"
    sudo apt -qq install network-manager libnss3-tools jq xsel -y
    echo  "\n${Green} * Package [network-manager libnss3-tools jq xsel] Successfully Installed ${Color_Off}"

    echo  "\n${Purple} * installing [php8.0-cli php8.0-curl php8.0-mbstring php8.0-mcrypt php8.0-xml php8.0-zip]...${Color_Off}"
    sudo apt install -qq php8.0-cli php8.0-curl php8.0-mbstring php8.0-mcrypt php8.0-xml php8.0-zip -y
    echo  "\n${Green} * Package [network-manager libnss3-tools jq xsel] Successfully Installed ${Color_Off}"
}


installApps(){

    echo  "\n${Purple} * Downloading Googel Chrome...${Color_Off}"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
    echo  "\n${Purple} * Google Chrome Download Success...${Color_Off}"

    echo  "\n${Purple} * Installing Google Chrome...${Color_Off}"
    sudo apt install ./google-chrome-stable_current_amd64.deb
    sudo apt -f install
    rm -rf ./google-chrome-stable_current_amd64.deb
    echo  "\n${Purple} * Google Chrome Successfully Installed ...${Color_Off}"

    echo  "\n${Purple} * Installing NodeJS ...${Color_Off}"
    curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt install -y nodejs
    echo  "\n${Purple} * NodeJs Successfully Installed ...${Color_Off}"

    echo  "\n${Purple} * Installing microsoft Edge ...${Color_Off}"
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
    sudo rm microsoft.gpg
    sudo apt update && sudo apt install microsoft-edge-beta -y
    echo  "\n${Purple} * Microsoft edge  Successfully Installed ...${Color_Off}"

}
bootstrap(){
    checkRoot
    update
    upgrade
    installBasic
    installPhp
    installMysql
    laravelPackage
    installApps
}

bootstrap
