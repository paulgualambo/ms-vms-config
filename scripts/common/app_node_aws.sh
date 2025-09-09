#!/bin/bash

# --- MODO ESTRICTO ---
# Terminar el script inmediatamente si un comando falla.
set -e

echo "🚀 Iniciando la configuración del entorno de desarrollo..."

# --- INSTALACIÓN DE NVM (NODE VERSION MANAGER) ---
echo "📦 Instalando NVM..."
# Descarga y ejecuta el script de instalación de NVM.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# --- CARGAR NVM EN LA SESIÓN ACTUAL DEL SCRIPT ---
# ¡Este es el paso clave para evitar el error!
# Exportamos la variable de entorno que NVM necesita.
export NVM_DIR="$HOME/.nvm"
# Cargamos el script de nvm si existe, haciéndolo disponible en este script.
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


# 2. ✅ --- LA CORRECCIÓN ES ESTA --- ✅
#    Carga NVM manualmente en la sesión actual del script.
#    Esto hace que el comando 'nvm' esté disponible de inmediato.
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
fi

echo "✅ NVM cargado en la sesión actual."

# --- CONFIGURACIÓN DE NODE.JS USANDO NVM ---
echo "📦 Instalando la última versión LTS de Node.js..."
nvm install --lts
#nvm use --lts

echo "npm: Actualizando a la última versión..."
npm install npm@latest -g

echo "🔍 Verificación de versiones de Node y NPM:"
node -v
npm -v

# --- ACTUALIZACIÓN DE PAQUETES E INSTALACIÓN DE DEPENDENCIAS ---
echo "🔧 Actualizando la lista de paquetes del sistema..."
sudo apt-get update
sudo apt-get install -y curl unzip # Instala dependencias necesarias

# --- INSTALACIÓN DE YARN ---
# Corregido para usar el método recomendado para sistemas basados en APT.
echo "📦 Instalando Yarn..."
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install -y yarn
echo "🔍 Verificación de versión de Yarn:"
yarn --version

echo "🎉 ¡Configuración completada!"
