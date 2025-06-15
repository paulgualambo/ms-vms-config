#!/bin/bash

# Obtener el JSON como argumento
json_input="$1"
PATH_JSON="$2"
TOKEN_GITHUB="$3"

# Verificar si se pasó un argumento
if [ -z "$json_input" ]; then
  echo "Por favor, proporciona un JSON como argumento."
  exit 1
fi

# Obtener el objeto dentro de "w001.app"
config=$(echo "$json_input" | jq -r $PATH_JSON)

echo $config

# Obtención de las variables
HOSTNAME_NEW=$(echo $config | jq -r '.HOSTNAME // "paul-laptop01-wsl-sandbox-app"')
USERNAME=$(echo $config | jq -r '.USERNAME // "paul"')
EMAIL=$(echo $config | jq -r '.EMAIL // "paul.gualambo@gmail.com"')
PASSWORD=$(echo $config | jq -r '.PASSWORD // "P@ul1984"')
DISTRO=$(echo $config | jq -r '.DISTRO // "DEBIAN"')
FULLNAME=$(echo $config | jq -r '.FULLNAME // "paul romualdo gualambo giraldo"')

# Aquí puedes agregar cualquier otra lógica que necesites para tu script

# sudo sed -i "s/${HOSTNAME_BASE}/${HOSTNAME_NEW}/g" /etc/hostname
# sudo sed -i "s/${HOSTNAME_BASE}/${HOSTNAME_NEW}/g" /etc/hosts

# sudo bash -c "cat << EOF >> /etc/wsl.conf
# [user]
# default=$USERNAME

# [network]
# hostname = $HOSTNAME_NEW
# generateHosts = false
# generateResolvConf = true
# EOF"

# sudo hostname $HOSTNAME_NEW

cd ~

rm -rf ~/config_vm

mkdir -p ~/config_vm
cd ~/config_vm
wget  --header="Authorization: token $TOKEN_GITHUB" --header="Accept: application/vnd.github.v3.raw" https://raw.githubusercontent.com/paulgualambo/ms-vms-configure-admin/main/wsl/install.sh
wget  --header="Authorization: token $TOKEN_GITHUB" --header="Accept: application/vnd.github.v3.raw" https://raw.githubusercontent.com/paulgualambo/ms-vms-configure-admin/main/wsl/startup.sh

sudo chmod 775 -R ~/config_vm

#ejecuta en la misma instancia del shell
. ~/config_vm/install.sh "{\"USERNAME\": \"$USERNAME\", \"EMAIL\": \"$EMAIL\", \"PASSWORD\": \"$PASSWORD\", \"DISTRO\": \"$DISTRO\"}"

#ejecuta en la misma instancia del shell
. ~/config_vm/startup.sh "{\"USERNAME\": \"$USERNAME\", \"EMAIL\": \"$EMAIL\", \"FULLNAME\": \"$FULLNAME\"}"

