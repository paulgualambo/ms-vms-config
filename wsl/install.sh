#!/bin/bash

# Descargar y ejecutar constants.sh para definir GITLIB_URL
source <(curl -s https://raw.githubusercontent.com/paulgualambo/ms-vms-config/refs/heads/main/scripts/constants.sh?123)

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
# Asegúrate de que GITLIB_URL esté definida ANTES de usarla
if [ -z "$GITLIB_URL" ]; then
  echo "Error: La variable GITLIB_URL no está definida."
  exit 1
fi
source <(curl -s "${GITLIB_URL}/scripts/common/function_create_user.sh") "$json_input"
echo "Ejecutando script de creación de usuario..." 
#example
#./install.sh "$(jq '.["<host>"]' ../workspace/ms_vms.json)"
#source ./install.sh "$(jq '.["pr2g-laptop01-w001-win11-wsl-sandbox"]' ${GITLIB_URL}/workspace/ms_vms.json)"

#apt install -y jq
#bash <(curl -s https://raw.githubusercontent.com/paulgualambo/ms-vms-config/refs/heads/main/wsl/install.sh) '{"hostname":"pr2g-laptop01-w001-win11-wsl-sandbox", "distro":"DEBIAN", "username":"paul", "email":"paul.gualambo@gmail.com", "password":"123456"}'
