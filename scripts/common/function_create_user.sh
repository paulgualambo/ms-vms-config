#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


### Logging helpers
log_info()  { echo "[INFO]  $*"; }
log_error() { echo "[ERROR] $*" >&2; }

### Usage message
usage() {
  cat <<EOF
Uso: $0 '<JSON>'

Ejemplo:
  $0 '{"DISTRO":"DEBIAN","USERNAME":"paul","EMAIL":"paul.gualambo@gmail.com","PASSWORD":"P@ul1984"}'
EOF
  exit 1
}

### Validate input arguments
validate_args() {
  if [[ $# -ne 1 ]]; then
    log_error "Se requiere exactamente un argumento JSON."
    usage
  fi
}

### Parse JSON fields with defaults
parse_json() {
  local json=$1
  USERNAME=$(jq -r '.username // "paul"' <<< "$json")
  EMAIL=$(jq -r '.email // "paul.gualambo@gmail.com"' <<< "$json")
  PASSWORD=$(jq -r '.password // "P@ul1984"' <<< "$json")
  DISTRO=$(jq -r '.distro // "DEBIAN"' <<< "$json")
}

### Check for dependencies
check_dependencies() {
  for cmd in jq wget; do
    if ! command -v "$cmd" &>/dev/null; then
      log_error "La utilidad '$cmd' no está instalada. Por favor instala '$cmd'."
      exit 1
    fi
  done
}

### Execute user creation script remotely
run_user_creation() {
  local distro=$1
  local user=$2
  local email=$3
  local pass=$4

  log_info "Ejecutando config_create_user.sh para $user en distro $distro..."
  sudo wget -qO- \
    "${GITLIB_URL}/scripts/lib/create_user.sh" \
    | bash -s -- "$distro" "$user" "$email" "$pass"
}

### Configuración de SSH
configure_ssh() {
  log_info "Instalando y configurando el servidor SSH para acceso con clave..."

  # 1. Instalar el paquete del SERVIDOR SSH
  sudo apt install openssh-server -y

  # 2. Modificar la configuración para mayor seguridad
  # Habilita la autenticación con clave pública (indispensable)
  sudo sed -i 's/^#*PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

  # DESHABILITA la autenticación con contraseña (el cambio clave)
  sudo sed -i 's/^#*PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config

  # Asegura que el servidor escuche en todas las interfaces
  sudo sed -i 's/^#*ListenAddress .*/ListenAddress 0.0.0.0/' /etc/ssh/sshd_config

  # 3. Reiniciar el servicio para aplicar los cambios
  sudo systemctl restart ssh.service

  log_info "Configuración de SSH completada. El acceso con contraseña está deshabilitado."
}

### Main flow
main() {
  validate_args "$@"
  check_dependencies
  parse_json "$1"

  log_info "Usuario: $USERNAME"
  run_user_creation "$DISTRO" "$USERNAME" "$EMAIL" "$PASSWORD"
  #Puedes invocar la función configure_ssh() si es necesario
  configure_ssh
}

main "$@"

#create_user.sh
#source ../scripts/common/create_user.sh "$json_input"
