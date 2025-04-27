#!/bin/bash
# 

# Este script instala Git, NVM (Node Version Manager) y AWS CLI en sistemas basados en Debian/Ubuntu.

echo "Iniciando la configuración del entorno de desarrollo..."

# --- Instalación de Git ---
echo -e "\n--- Instalando Git ---"
sudo apt update
sudo apt install -y git

if command -v git &>/dev/null; then
    echo "Git se ha instalado correctamente."
    git --version
else
    echo "Error: Git no se pudo instalar."
    exit 1
fi

# --- Instalación de NVM (Node Version Manager) ---
# NVM se instala para el usuario actual. Es importante que no uses sudo para NVM.
echo -e "\n--- Instalando NVM (Node Version Manager) ---"

# Descargar y ejecutar el script de instalación de NVM
# Usamos el link directo para la última versión (puedes verificar en https://github.com/nvm-sh/nvm/releases)
NVM_INSTALL_URL="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh"
curl -o- "$NVM_INSTALL_URL" | bash

# Cargar NVM para que esté disponible en esta sesión
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v nvm &>/dev/null; then
    echo "NVM se ha instalado correctamente."
    echo "Instalando la versión LTS de Node.js..."
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*' # Establecer la versión LTS como predeterminada

    if command -v npm &>/dev/null; then
        echo "Node.js y npm se han instalado correctamente a través de NVM."
        node --version
        npm --version
    else
        echo "Error: Node.js/npm no se pudo instalar a través de NVM."
        exit 1
    fi
else
    echo "Error: NVM no se pudo instalar. Asegúrate de que curl esté instalado y tengas conexión a internet."
    echo "Podrías necesitar cerrar y reabrir tu terminal, o ejecutar 'source ~/.bashrc' (o ~/.zshrc) para que NVM esté disponible."
fi


# --- Instalación de AWS CLI v2 ---
echo -e "\n--- Instalando AWS CLI v2 ---"

# 1. Descargar el instalador de AWS CLI v2
AWS_CLI_V2_ZIP="awscliv2.zip"
AWS_CLI_INSTALLER_DIR="/tmp/aws-cli-install"
AWS_CLI_BIN_DIR="/usr/local/bin"

echo "Descargando el paquete de instalación de AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$AWS_CLI_V2_ZIP"

# 2. Descomprimir el instalador en un directorio temporal
echo "Descomprimiendo el paquete de instalación..."
mkdir -p "$AWS_CLI_INSTALLER_DIR"
unzip "$AWS_CLI_V2_ZIP" -d "$AWS_CLI_INSTALLER_DIR"

# 3. Ejecutar el instalador de AWS CLI
echo "Ejecutando el instalador de AWS CLI..."
sudo "$AWS_CLI_INSTALLER_DIR/aws/install" --bin-dir "$AWS_CLI_BIN_DIR" --install-dir /usr/local/aws-cli --update

# Limpiar archivos temporales
echo "Limpiando archivos temporales..."
rm -f "$AWS_CLI_V2_ZIP"
rm -rf "$AWS_CLI_INSTALLER_DIR"

if command -v aws &>/dev/null; then
    echo "AWS CLI v2 se ha instalado correctamente."
    aws --version
else
    echo "Error: AWS CLI v2 no se pudo instalar."
    echo "Asegúrate de que 'unzip' esté instalado (sudo apt install unzip) y de tener conexión a internet."
    exit 1
fi

echo -e "\n--- Configuración completada ---"
echo "Por favor, considera cerrar y volver a abrir tu terminal o ejecutar 'source ~/.bashrc' (o ~/.zshrc) para asegurar que todas las variables de entorno se carguen correctamente."
echo "Luego, puedes configurar tu AWS CLI con 'aws configure'."