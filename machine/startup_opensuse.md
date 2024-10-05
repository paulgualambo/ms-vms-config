# STARTUP_RHEL

## INSTALL

- chrome
- vscode

## UPDATE PACKAGE

```sh
sudo zypper update -y
sudo zypper upgrade -y
sudo zypper install git -y
```

## SETTINGS

```sh
#!/bin/bash

# Definir el nuevo hostname
NEW_HOSTNAME="paul-pc01-opensuse"
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
sudo chown paul:paul ~/.ssh/paul-*
sudo chmod 600 ~/.ssh/paul-*
```

## Install basic dev

```sh
USERNAME="paul"
sudo wget -O - https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/config_install_software_dev.sh | bash -s -- "$USERNAME"
source ~/.bashrc

```

## Config git and install nodejs


## Install Virtual Box y Vagrant

```sh
sudo zypper install -y @development-tools
sudo zypper install -y kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
sudo zypper config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo zypper install -y VirtualBox-7.0
sudo /sbin/vboxconfig
VBoxManage --version

sudo zypper install -y vagrant
vagrant --version

```
