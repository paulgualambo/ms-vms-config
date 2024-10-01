# STARTUP_RHEL

## INSTALL

- chrome
- vscode

## UPDATE PACKAGE

```sh
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install git -y
```

## SETTINGS

```sh
#!/bin/bash

# Definir el nuevo hostname
NEW_HOSTNAME="paul-laptop01-fedora"
# Cambiar el hostname temporalmente (aplicable en Debian y Red Hat)
sudo hostnamectl set-hostname $NEW_HOSTNAME
# Actualizar el archivo /etc/hostname (para que el cambio sea persistente después de reiniciar)
echo $NEW_HOSTNAME | sudo tee /etc/hostname
# Actualizar el archivo /etc/hosts (sustituyendo el antiguo hostname por el nuevo)
sudo sed -i "s/$(hostname)/$NEW_HOSTNAME/g" /etc/hosts
# Verificar el cambio
echo "El nuevo hostname es: $(hostname)"

```

## Keys

```sh
sudo chmod 600 ~/.ssh/paul-*
```

## Install basic dev

```sh
USERNAME="paul"
sudo wget -O - https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/config_install_software_dev_rhel.sh | bash -s -- "$USERNAME"
source ~/.bashrc

```

## Config git and install nodejs


## Install Virtual Box y Vagrant

```sh
sudo dnf install -y @development-tools
sudo dnf install -y kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
sudo dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo dnf install -y VirtualBox-7.0
sudo /sbin/vboxconfig
VBoxManage --version

sudo dnf install -y vagrant
vagrant --version

```
