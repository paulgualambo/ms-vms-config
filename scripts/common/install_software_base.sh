#!/bin/bash

# ===================================================================================
#   Script para Configurar un Entorno de Desarrollo en Linux
#
#   Este script automatiza la instalación y configuración de herramientas
#   esenciales para el desarrollo. Acepta una cadena JSON como argumento
#   para personalizar la configuración.
#
#   Autor: Gemini (basado en los scripts de Paul Gualambo)
#   Versión: 2.0
# ===================================================================================

# --- MODO ESTRICTO Y SEGURO ---
set -euo pipefail

# --- CONSTANTES Y COLORES ---
readonly C_RESET='\033[0m'
readonly C_RED='\033[0;31m'
readonly C_GREEN='\033[0;32m'
readonly C_BLUE='\033[0;34m'

# --- FUNCIONES DE LOGGING ---
log_info() { echo -e "${C_BLUE}INFO: $1${C_RESET}"; }
log_success() { echo -e "${C_GREEN}SUCCESS: $1${C_RESET}"; }
log_error() { echo -e "${C_RED}ERROR: $1${C_RESET}"; exit 1; }

# --- FUNCIÓN PRINCIPAL ---
# Orquesta la ejecución de todas las tareas.
main() {
    # 1. Verificar que el script no se ejecute como root
    if [[ "${EUID}" -eq 0 ]]; then
        log_error "Este script no debe ejecutarse como root. Usa sudo cuando sea necesario."
    fi

    # 2. Detectar el gestor de paquetes
    detect_package_manager

    # 3. Instalar paquetes básicos (incluyendo jq, necesario para el siguiente paso)
    install_packages

    # 4. Procesar el argumento JSON de entrada
    local json_input="${1-}"
    if [[ -z "${json_input}" ]]; then
        log_error "Por favor, proporciona la configuración en formato JSON como primer argumento."
    fi

    local hostname username email password
    hostname=$(echo "${json_input}" | jq -r '.hostname')
    username=$(echo "${json_input}" | jq -r '.username')
    email=$(echo "${json_input}" | jq -r '.email')
    password=$(echo "${json_input}" | jq -r '.password') # Nota: la contraseña se lee pero no se usa en este script

    if [[ -z "${username}" || "${username}" == "null" ]]; then
        log_error "El JSON de entrada debe contener un 'username' válido."
    fi

    log_info "Configuración recibida:"
    echo -e "  - Hostname: ${hostname}\n  - Usuario:  ${username}\n  - Email:    ${email}"

    # 5. Continuar con el resto de la configuración usando las variables del JSON
    ensure_user_exists "${username}"
    configure_timezone
    install_docker "${username}"
    install_aws_cli
    configure_shell "${username}"

    log_success "¡Configuración completada para el usuario ${username}!"
    log_info "IMPORTANTE: Para que los cambios del grupo Docker surtan efecto, debes cerrar sesión y volver a iniciarla."
}

# --- DETECCIÓN DEL GESTOR DE PAQUETES ---
detect_package_manager() {
    # (Sin cambios)
    if command -v apt-get &>/dev/null; then
        readonly PKG_MANAGER="apt-get"; readonly PKG_UPDATE_CMD="sudo ${PKG_MANAGER} update"; readonly PKG_INSTALL_CMD="sudo ${PKG_MANAGER} install -y"
    elif command -v dnf &>/dev/null; then
        readonly PKG_MANAGER="dnf"; readonly PKG_UPDATE_CMD="sudo ${PKG_MANAGER} check-update"; readonly PKG_INSTALL_CMD="sudo ${PKG_MANAGER} install -y"
    elif command -v zypper &>/dev/null; then
        readonly PKG_MANAGER="zypper"; readonly PKG_UPDATE_CMD="sudo ${PKG_MANAGER} refresh"; readonly PKG_INSTALL_CMD="sudo ${PKG_MANAGER} install -y"
    elif command -v pacman &>/dev/null; then
        readonly PKG_MANAGER="pacman"; readonly PKG_UPDATE_CMD="sudo ${PKG_MANAGER} -Syu --noconfirm"; readonly PKG_INSTALL_CMD="sudo ${PKG_MANAGER} -S --noconfirm"
    else
        log_error "No se pudo detectar un gestor de paquetes compatible."
    fi
    log_info "Gestor de paquetes detectado: ${PKG_MANAGER}"
}

# --- CREACIÓN DE USUARIO ---
ensure_user_exists() {
    # (Sin cambios)
    local user_to_check="$1"
    if ! id -u "${user_to_check}" &>/dev/null; then
        log_info "El usuario '${user_to_check}' no existe. Creándolo ahora..."
        sudo useradd -m -s /bin/bash "${user_to_check}"; sudo usermod -aG sudo "${user_to_check}"
        log_success "Usuario '${user_to_check}' creado y añadido al grupo sudo."
    else
        log_info "El usuario '${user_to_check}' ya existe."
    fi
}

# --- INSTALACIÓN DE PAQUETES ---
install_packages() {
    log_info "Actualizando el índice de paquetes..."
    eval "${PKG_UPDATE_CMD}"

    log_info "Instalando paquetes básicos y de desarrollo..."

    # 1. Lista de paquetes comunes a TODAS las distribuciones
    local packages=(
        curl
        bash
        git
        net-tools
        rsync
        ca-certificates
        unzip
        jq
        bash-completion
    )

    # 2. Añadir paquetes específicos para cada gestor de paquetes
    case "${PKG_MANAGER}" in
        "apt-get")
            packages+=(
                apt-transport-https
                software-properties-common
            )
            ;;
        "dnf")
            # Fedora/CentOS usualmente no necesita equivalentes directos
            # o ya los incluye. Podemos añadir paquetes específicos aquí si es necesario.
            # Por ejemplo: 'dnf-utils' podría ser un análogo.
            packages+=(
                'dnf-plugins-core'
            )
            ;;
        "zypper")
            # openSUSE
            # No se necesitan paquetes adicionales de esta lista.
            ;;
        "pacman")
            # Arch Linux
            # No se necesitan paquetes adicionales de esta lista.
            ;;
    esac

    log_info "Paquetes a instalar: ${packages[*]}"
    eval "${PKG_INSTALL_CMD} ${packages[*]}"

    log_success "Paquetes básicos, Git, jq y dependencias instalados."
}

# --- CONFIGURACIÓN DE ZONA HORARIA ---
configure_timezone() {
    # (Sin cambios)
    log_info "Configurando la zona horaria a America/Lima..."
    sudo timedatectl set-timezone "America/Lima"
}

# --- INSTALACIÓN DE DOCKER ---
install_docker() {
    # (Sin cambios)
    local user_to_configure="$1"
    # ... (código de instalación de Docker)
    if ! command -v docker &>/dev/null; then
        log_info "Instalando Docker..."; curl -fsSL https://get.docker.com -o get-docker.sh; sudo sh get-docker.sh; rm get-docker.sh
        sudo usermod -aG docker "${user_to_configure}"; log_success "Docker instalado y usuario añadido al grupo docker."
    else
        log_info "Docker ya está instalado."
    fi
    if ! command -v docker-compose &>/dev/null; then
        log_info "Instalando Docker Compose..."; local compose_url="https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)"
        sudo curl -L "${compose_url}" -o /usr/local/bin/docker-compose; sudo chmod +x /usr/local/bin/docker-compose; log_success "Docker Compose instalado."
    else
        log_info "Docker Compose ya está instalado."
    fi
}

# --- INSTALACIÓN DE AWS CLI ---
install_aws_cli() {
    # (Sin cambios)
    if command -v aws &>/dev/null; then
        log_info "AWS CLI ya está instalado. Versión actual: $(aws --version)"; return
    fi
    log_info "Instalando AWS CLI v2..."; local TEMP_DIR; TEMP_DIR=$(mktemp -d); trap 'rm -rf -- "$TEMP_DIR"' EXIT; local aws_zip_path="${TEMP_DIR}/awscliv2.zip"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "${aws_zip_path}"; unzip "${aws_zip_path}" -d "${TEMP_DIR}"; sudo "${TEMP_DIR}/aws/install" --update
    if command -v aws &>/dev/null; then
        log_success "AWS CLI v2 instalado correctamente. Versión: $(aws --version)"
    else
        log_error "La instalación de AWS CLI v2 falló."
    fi
}

# --- CONFIGURACIÓN DEL SHELL DEL USUARIO ---
configure_shell() {
    # (Sin cambios)
    local user_to_configure="$1"; local user_home="/home/${user_to_configure}"; local user_bashrc="${user_home}/.bashrc"; local user_config_dir="${user_home}/.config"
    log_info "Configurando el shell para '${user_to_configure}'..."; sudo tee -a "${user_bashrc}" > /dev/null <<EOF

# --- Configuración de autocompletado ---
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# --- Configuración de Starship Prompt ---
eval "\$(starship init bash)"

# --- Configuración del Agente SSH ---
if ! pgrep -u "${user_to_configure}" ssh-agent > /dev/null; then
    eval "\$(ssh-agent -s)"
fi
EOF
    if ! command -v starship &>/dev/null; then
        log_info "Instalando Starship..."; curl -sS https://starship.rs/install.sh | sudo sh -s -- --yes
    fi
    log_info "Configurando Starship..."; sudo mkdir -p "${user_config_dir}"; sudo wget -O "${user_config_dir}/starship.toml" https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/starship.toml
    sudo chown -R "${user_to_configure}:${user_to_configure}" "${user_home}"; log_success "Shell configurado para '${user_to_configure}'."
}

# --- PUNTO DE ENTRADA DEL SCRIPT ---
main "$@"
