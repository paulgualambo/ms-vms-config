#!/bin/bash
set -x
# URL del archivo remoto
REMOTE_URL="https://raw.githubusercontent.com/paulgualambo/ms-vms-config/refs/heads/main/wsl/wsl.conf?${RANDOM}"

# Obtener el JSON como argumento
json_input="$1"

# Verificar si se pasó un argumento
if [ -z "$json_input" ]; then
  echo "Por favor, proporciona un JSON como argumento."
  exit 1
fi

NUEVO_HOSTNAME=$(echo "$json_input" | jq -r '.hostname')
DISTRO=$(echo "$json_input" | jq -r '.distro')
NUEVO_USERNAME=$(echo "$json_input" | jq -r '.username')
EMAIL=$(echo "$json_input" | jq -r '.email')
PASSWORD=$(echo "$json_input" | jq -r '.password')

# Archivo de destino
CONFIG_FILE="/etc/wsl.conf"

# Descargar el archivo remoto y almacenar su contenido en una variable
CONTENT=$(curl -s "$REMOTE_URL")

# Verificar si la descarga fue exitosa
if [ -z "$CONTENT" ]; then
  echo "Error: No se pudo descargar el archivo desde $REMOTE_URL"
  exit 1
fi

# Realizar los reemplazos
MODIFIED_CONTENT=$(echo "$CONTENT" | sed "s/USERNAME_DEFAULT_TO_REPLACE/$NUEVO_USERNAME/g")
MODIFIED_CONTENT=$(echo "$MODIFIED_CONTENT" | sed "s/HOSTNAME_TO_REPLACE/$NUEVO_HOSTNAME/g")

# Escribir el contenido modificado al archivo /etc/wsl.conf
echo "$MODIFIED_CONTENT" | sudo tee "$CONFIG_FILE"

# Verificar si la escritura fue exitosa (puedes agregar más verificaciones si es necesario)
if [ $? -eq 0 ]; then
  echo "Archivo $CONFIG_FILE modificado exitosamente."
else
  echo "Error al escribir en $CONFIG_FILE."
  exit 1
fi
