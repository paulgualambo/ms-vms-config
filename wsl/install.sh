#!/bin/bash

# Obtener el JSON como argumento
json_input="$1"

# Verificar si se pasó un argumento
if [ -z "$json_input" ]; then
  echo "Por favor, proporciona un JSON como argumento."
  exit 1
fi

# Obtención de las variables
USERNAME=$(echo $json_input | jq -r '.USERNAME // "paul"')
EMAIL=$(echo $json_input | jq -r '.EMAIL // "paul.gualambo@gmail.com"')
PASSWORD=$(echo $json_input | jq -r '.PASSWORD // "P@ul1984"')
DISTRO=$(echo $json_input | jq -r '.DISTRO // "DEBIAN"')

# Imprimir el nombre de usuario para verificar
echo "Ejecutando scripts como el usuario: $USERNAME"

# Ejecutar el primer script para crear un usuario
sudo wget -O - https://raw.githubusercontent.com/paulgualambo/env-tools/main/linux/config_create_user.sh | bash -s -- "$DISTRO" "$USERNAME" "$EMAIL" "$PASSWORD"

# Ejecutar el segundo script para instalar software de desarrollo
sudo wget -O - https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/config_install_software_dev_wsl.sh | bash -s -- "$USERNAME"

echo "Scripts ejecutados correctamente."

# copiar scripts
echo "COPIAR SCRIPTS"
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/config_vm/
sudo chmod 755 -R /home/$USERNAME/config_vm/*.sh

echo "copia .ssh .aws"
cd ~
mkdir -p .ssh .aws
cp -R /mnt/c/Users/$USERNAME/.ssh/. ~/.ssh/
cp -R /mnt/c/Users/$USERNAME/.aws/. ~/.aws/
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh /home/$USERNAME/.aws
sudo chmod 700 -R /home/$USERNAME/.ssh /home/$USERNAME/.aws

echo "Scripts copiados correctamente."

#Add .bashrc
echo -e '\n# Iniciar el agente SSH\n' >> ~/.bashrc
echo 'eval "$(ssh-agent -s)"' >> ~/.bashrc
echo -e '\n# Agregar todas las claves SSH que coincidan con el patrón\n' >> ~/.bashrc
echo "for key in ~/.ssh/\${USER}-*-id-key_ed25519; do" >> ~/.bashrc
echo '    ssh-add "$key" ' >> ~/.bashrc
echo 'done' >> ~/.bashrc
echo 'echo "All SSH keys have been added successfully."' >> ~/.bashrc

source ~/.bashrc