#!/bin/bash

# Definir variables
USERNAME="paul"
DISTRO="DEBIAN"
EMAIL="paul.gualambo@gmail.com"
PASSWORD="P@ul1984"

# Imprimir el nombre de usuario para verificar
echo "Ejecutando scripts como el usuario: $USERNAME"

# Ejecutar el primer script para crear un usuario
sudo wget -O - https://raw.githubusercontent.com/paulgualambo/env-tools/main/linux/config_create_user.sh | bash -s -- "$DISTRO" "$USERNAME" "$EMAIL" "$PASSWORD"

echo "Scripts ejecutados correctamente."

# copiar scripts
echo "COPIAR SCRIPTS"
sudo mkdir -p /home/$USERNAME/config_vm
ls -a /vagrant/scripts_to_provision/
sudo cp -Rv /vagrant/scripts_to_provision/. /home/$USERNAME/config_vm/

# # copiar .ssh
sudo cp -R /home/$USERNAME/config_vm/.ssh/. /home/$USERNAME/.ssh/
sudo cp -R /home/$USERNAME/config_vm/.aws/. /home/$USERNAME/.aws/

#accesos
echo "COPIANDO SSH AWS"
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/config_vm/

sudo chmod 755 -R /home/$USERNAME/config_vm/*.sh
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh /home/$USERNAME/.aws
sudo chmod 700 -R /home/$USERNAME/.ssh /home/$USERNAME/.aws

cat /home/$USERNAME/.ssh/id_ed25519.pub
sudo cat /home/$USERNAME/.ssh/id_ed25519.pub >> /home/$USERNAME/.ssh/authorized_keys
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh /home/$USERNAME/.aws
sudo chmod 700 -R /home/$USERNAME/.ssh /home/$USERNAME/.aws
sudo chmod 600 -R /home/$USERNAME/.ssh/authorized_keys
echo "Scripts copiados correctamente."

echo "Eliminando .ssh and .aws"
sudo rm -rf /home/$USERNAME/config_vm/.ssh /home/$USERNAME/config_vm/.aws