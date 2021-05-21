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

bootstrap(){
    #installPhp
    installMysql
}
bootstrap
