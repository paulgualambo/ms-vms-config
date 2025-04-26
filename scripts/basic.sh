#!/bin/bash

#Función para detectar el gestor de paquetes según la distribución
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


## UPDATE PACKAGE
update_packages() {
    PKG_MANAGER=$(detect_package_manager)

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

# Función para determinar la familia de distro
distro_family() {
    # Primero comprobamos que /etc/os-release exista
    if [[ -f /etc/os-release ]]; then
        # Cargamos las variables definidas en /etc/os-release
        . /etc/os-release

        # Normalmente, ID_LIKE es lo más útil para ver a qué familia pertenece
        if [[ -n "$ID_LIKE" ]]; then
        # Convertimos a minúsculas por robustez
        local like_lower
        like_lower=$(echo "$ID_LIKE" | tr '[:upper:]' '[:lower:]')

        if [[ "$like_lower" =~ debian ]]; then
            echo "Debian"
        elif [[ "$like_lower" =~ rhel|fedora|centos ]]; then
            echo "RedHat"
        elif [[ "$like_lower" =~ suse ]]; then
            echo "SUSE"
        elif [[ "$like_lower" =~ arch ]]; then
            echo "Arch"
        else
            echo "Familia desconocida (ID_LIKE: $ID_LIKE)"
        fi

        # Si no existe ID_LIKE, probamos con ID directamente
        elif [[ -n "$ID" ]]; then
        local id_lower
        id_lower=$(echo "$ID" | tr '[:upper:]' '[:lower:]')

        if [[ "$id_lower" =~ debian|ubuntu ]]; then
            echo "Debian"
        elif [[ "$id_lower" =~ fedora|centos|rhel ]]; then
            echo "RedHat"
        elif [[ "$id_lower" =~ suse ]]; then
            echo "SUSE"
        elif [[ "$id_lower" =~ arch ]]; then
            echo "Arch"
        else
            echo "Familia desconocida (ID: $ID)"
        fi
        else
        echo "No se encontró información de ID o ID_LIKE en /etc/os-release."
        fi
    else
        echo "No existe /etc/os-release, imposible determinar la familia de distro."
    fi
}



## SETTINGS - Cambiar el hostname
set_hostname() {

    #mv ~/.config/google-chrome ~/.config/google-chrome-backup

    NEW_HOSTNAME=${1:-"pr2g-pc01-personal-ubuntu"}
    sudo hostnamectl set-hostname $NEW_HOSTNAME
    echo $NEW_HOSTNAME | sudo tee /etc/hostname
    sudo sed -i "s/$(hostname)/$NEW_HOSTNAME/g" /etc/hosts
    echo "El nuevo nombre del hostname es: $(hostname)"
}

create_user(){
    DISTRO=$(distro_family)
    DISTRO=${DISTRO^^}

    # Definir variables
    _USERNAME=${1:-"paul"}
    _DISTRO=$DISTRO
    _EMAIL=${2:-"paul.gualambo@gmail.com"}
    _PASSWORD=${3:-"P@ul1984"}

    # Imprimir valores
    echo "Ejecutando scripts como el usuario: $_USERNAME"
    echo "DISTRO FAMILY: $_DISTRO"

    # Ejecutar el primer script para crear un usuario
    sudo wget -O - --no-verbose https://raw.githubusercontent.com/paulgualambo/env-tools/main/linux/config_create_user.sh | bash -s -- "$_DISTRO" "$_USERNAME" "$_EMAIL" "$_PASSWORD"
}

## Keys
# configure_ssh_keys() {
#     sudo cp /mnt/paul-disk01-data_shared_ext4/workspaces/keys/paul-* /home/paul/.ssh/
#     sudo chown paul:paul ~/.ssh/paul-*
#     sudo chmod 600 ~/.ssh/paul-*
# }

## Install basic dev tools
install_dev_tools() {
    USERNAME=${1:-"paul"}
    sudo wget -O - --no-verbose https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/config_install_software_dev.sh | bash -s -- "$USERNAME"
    source ~/.bashrc
}

## Config Git y NodeJS (se puede añadir la lógica aquí según sea necesario)

## Install VirtualBox y Vagrant
# install_virtualbox_vagrant() {
#     case $PKG_MANAGER in
#         "apt")
#             sudo apt install -y build-essential linux-headers-$(uname -r)
#             sudo apt-add-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
#             wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
#             sudo apt update
#             sudo apt install -y virtualbox-7.0
#             ;;
#         "dnf")
#             sudo dnf install -y @development-tools kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
#             sudo dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
#             sudo dnf install -y VirtualBox-7.0
#             ;;
#         "pacman")
#             sudo pacman -S --noconfirm virtualbox virtualbox-host-modules-arch
#             ;;
#         "zypper")
#             sudo zypper install -y @development-tools kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
#             sudo zypper config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
#             sudo zypper install -y VirtualBox-7.0
#             ;;
#         *)
#             echo "Package manager not supported."
#             exit 1
#             ;;
#     esac

#     sudo /sbin/vboxconfig
#     VBoxManage --version
#     sudo $PKG_MANAGER install -y vagrant
#     vagrant --version

#     sudo chown -R  paul:paul /mnt/paul-pc01-data_shared_ext4/virtualbox/
#     sudo mkdir -p /mnt/paul-pc01-data_shared_ext4/virtualbox/vms
#     sudo ln -s /mnt/paul-pc01-data_shared_ext4/virtualbox/vms "/home/paul/VirtualBox VMs"
# }

# # Llamar a las funciones según lo necesario
# # Montar disco duro local
# # Montar disco externo
# sudo mkdir -p /mnt/pr2g-disk01
# sudo chown paul:paul -R /mnt/pr2g-disk01
# sudo mount /dev/sdb5 /mnt/pr2g-disk01

#install_software
#set_hostname "pr2g-pc01-personal-ubuntu"
# create_user "paul"
# update_packages
# configure_ssh_keys
# install_dev_tools
#install_virtualbox_vagrant

# Verifica si se pasa una función como argumento
if declare -f "$1" > /dev/null; then
    # Llama a la función con los argumentos proporcionados
    "$@"
else
    echo "Función no encontrada: $1"
    echo "Las funciones disponibles son: create_user set_hostname"
    exit 1
fi
