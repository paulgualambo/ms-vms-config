#!/bin/bash

# Función para detectar el gestor de paquetes según la distribución
detect_package_manager(){
    if [ -x "$(command -v apt)" ]; then
        echo "apt"
    elif [ -x "$(command -v dnf)" ]; then
        echo "dnf"
    elif [ -x "$(command -v pacman)" ]; then
        echo "pacman"
    elif [ -x "$(command -v zypper)" ]; then
        echo "zypper"
    else
        echo "No compatible package manager found."
        exit 1
    fi
}

# Asignar el gestor de paquetes a una variable
PKG_MANAGER=$(detect_package_manager)

# STARTUP_RHEL - Generalizado para las distribuciones soportadas

## UPDATE PACKAGE
update_packages() {
    case $PKG_MANAGER in
        "apt")
            sudo apt update -y
            sudo apt upgrade -y
            sudo apt install git -y
            ;;
        "dnf")
            sudo dnf update -y
            sudo dnf install git -y
            ;;
        "pacman")
            sudo pacman -Syu --noconfirm
            sudo pacman -S --noconfirm git
            ;;
        "zypper")
            sudo zypper update -y
            sudo zypper install git -y
            ;;
        *)
            echo "Package manager not supported."
            exit 1
            ;;
    esac
}

## SETTINGS - Cambiar el hostname
set_hostname() {
    NEW_HOSTNAME="paul-pc01-ubuntu"
    sudo hostnamectl set-hostname $NEW_HOSTNAME
    echo $NEW_HOSTNAME | sudo tee /etc/hostname
    sudo sed -i "s/$(hostname)/$NEW_HOSTNAME/g" /etc/hosts
    echo "El nuevo hostname es: $(hostname)"
}

## Keys
configure_ssh_keys() {
    sudo chown paul:paul ~/.ssh/paul-*
    sudo chmod 600 ~/.ssh/paul-*
}

## Install basic dev tools
install_dev_tools() {
    USERNAME="paul"
    sudo wget -O - https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/config_install_software_dev.sh | bash -s -- "$USERNAME"
    source ~/.bashrc
}

## Config Git y NodeJS (se puede añadir la lógica aquí según sea necesario)

## Install VirtualBox y Vagrant
install_virtualbox_vagrant() {
    case $PKG_MANAGER in
        "apt")
            sudo apt install -y build-essential linux-headers-$(uname -r)
            sudo apt-add-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
            wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
            sudo apt update
            sudo apt install -y virtualbox-7.0
            ;;
        "dnf")
            sudo dnf install -y @development-tools kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
            sudo dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
            sudo dnf install -y VirtualBox-7.0
            ;;
        "pacman")
            sudo pacman -S --noconfirm virtualbox virtualbox-host-modules-arch
            ;;
        "zypper")
            sudo zypper install -y @development-tools kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
            sudo zypper config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
            sudo zypper install -y VirtualBox-7.0
            ;;
        *)
            echo "Package manager not supported."
            exit 1
            ;;
    esac

    sudo /sbin/vboxconfig
    VBoxManage --version
    sudo $PKG_MANAGER install -y vagrant
    vagrant --version
}

# Llamar a las funciones según lo necesario
#install_software
update_packages
set_hostname
configure_ssh_keys
install_dev_tools
#install_virtualbox_vagrant
