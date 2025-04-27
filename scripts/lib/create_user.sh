#!/bin/bash

# References
# https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/

#Execute remote script
# wget -O - https://raw.githubusercontent.com/paulgualambo/env-tools/main/linux/config_create_user.sh | bash -s "RED_HAT" "paul" "paul.gualambo@gmail.com" "P@ul1984"

# wget -O - https://raw.githubusercontent.com/paulgualambo/env-tools/main/linux/config_create_user.sh | bash -s "DEBIAN" "paul" "paul.gualambo@gmail.com" "P@ul1984"


#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

### Constantes de distribución
readonly DISTRO_DEBIAN="DEBIAN"
readonly DISTRO_RED_HAT="RED_HAT"

### Funciones de logging
log_info()  { echo "[INFO]  $*"; }
log_error() { echo "[ERROR] $*" >&2; }

### Mostrar uso y salir
usage() {
  cat <<EOF
Uso: $0 <DEBIAN|RED_HAT> <USERNAME> <EMAIL> <PASSWORD>

Ejemplo:
  $0 DEBIAN paul paul.gualambo@gmail.com P@ul1984
EOF
  exit 1
}

### Validar argumentos de entrada
validate_args() {
  if [[ $# -ne 4 ]]; then
    log_error "Número de argumentos incorrecto."
    usage
  fi
}

### Crear usuario si no existe
create_user() {
  local user=$1
  local comment=$2
  
  if id "$user" &>/dev/null; then
    log_info "El usuario '$user' ya existe; saltando creación."
  else
    log_info "Creando usuario '$user'..."
    sudo useradd -m -s /bin/bash -c "$comment" "$user"
  fi
}

### Establecer contraseña
set_password() {
  local user=$1
  local password=$2
  
  log_info "Asignando contraseña para '$user'..."
  echo "${user}:${password}" | sudo chpasswd
}

### Agregar a grupo de sudoers
add_sudo_group() {
  local user=$1
  local group=$2
  
  if id -nG "$user" | grep -qw "$group"; then
    log_info "El usuario '$user' ya pertenece al grupo '$group'."
  else
    log_info "Añadiendo '$user' al grupo '$group'..."
    sudo usermod -aG "$group" "$user"
  fi
}

### Mostrar resumen del usuario
show_user_entry() {
  local user=$1
  log_info "Entrada en /etc/passwd para '$user':"
  grep "^${user}:" /etc/passwd
}

### Flujo principal
main() {
  validate_args "$@"

  local distro="$1"
  local user="$2"
  local email="$3"
  local pass="$4"
  local comment="${user} <${email}>"

  create_user "$user" "$comment"
  set_password "$user" "$pass"

  case "$distro" in
    "$DISTRO_DEBIAN")
      add_sudo_group "$user" "sudo"
      ;;
    "$DISTRO_RED_HAT")
      add_sudo_group "$user" "wheel"
      ;;
    *)
      log_error "Distribución no reconocida: '$distro'"
      usage
      ;;
  esac

  show_user_entry "$user"
}

main "$@"
