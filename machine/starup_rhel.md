# STARTUP_RHEL

## INSTALL

- chrome
- vscode

## UPDATE PACKAGE

```sh
sudo dnf update -y
sudo dnf upgrade -y
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

```

## Config git and install nodejs