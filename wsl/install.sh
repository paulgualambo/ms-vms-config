#!/bin/bash

source ../scripts/constants.sh

# Obtener el JSON como argumento
json_input="$1"

# Verificar si se pasó un argumento
if [ -z "$json_input" ]; then
  echo "Por favor, proporciona un JSON como argumento."
  exit 1
fi

HOSTNAME=$(echo "$json_input" | jq -r '.hostname')
DISTRO=$(echo "$json_input" | jq -r '.distro')
USERNAME=$(echo "$json_input" | jq -r '.username')
EMAIL=$(echo "$json_input" | jq -r '.email')
PASSWORD=$(echo "$json_input" | jq -r '.password')

echo "Hostname: $HOSTNAME"
echo "Distro: $DISTRO"
echo "Username: $USERNAME"
echo "Email: $EMAIL"
echo "Password: $PASSWORD"

#create_user.sh
source ../scripts/common/create_user.sh "$json_input"

#example
#./install.sh "$(jq '.["<host>"]' ../workspace/ms_vms.json)"
#source ./install.sh "$(jq '.["pr2g-laptop01-w001-win11-wsl-sandbox"]' ${GITLIB_URL}/workspace/ms_vms.json)"