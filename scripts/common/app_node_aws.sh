#!/bin/bash

cd ~

#configure node and npm
# Install nvm
#https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Carga la autocompletación de nvm si está presente
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm --version
nvm ls-remote
nvm ls
nvm run node --version
nvm install --lts
nvm install-latest-npm
nvm cache clear

# create .nvmrc
# echo "lts/*" > .nvmrc # to default to the latest LTS version

npm install npm@latest -g
node -v
npm -v

# Install typescript
# Install TS globally on my machine
# npm i -D -g typescript@latest
# npm i -D -g @types/node ts-node@latest
# # Check version
# tsc -v

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo dnf-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/dnf/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn -y
yarn --version

#AWS
#!/bin/bash

# --- Script para instalar AWS CLI v2 en sistemas Debian/Ubuntu ---

# 1. Terminar el script inmediatamente si un comando falla (modo estricto).
set -e

# 2. Verificar si AWS CLI ya está instalado para no reinstalar.
if command -v aws &> /dev/null; then
    echo "✅ AWS CLI ya está instalado. Versión actual:"
    aws --version
    exit 0
fi

echo "🚀 Iniciando la instalación de AWS CLI v2..."

# 3. Crear un directorio temporal seguro para los archivos de instalación.
# Esto asegura que todos los archivos descargados estén aislados y se puedan limpiar fácilmente.
TEMP_DIR=$(mktemp -d)
echo "📂 Usando directorio temporal: ${TEMP_DIR}"

# 4. Actualizar la lista de paquetes e instalar 'unzip' si es necesario.
echo "🔧 Actualizando paquetes e instalando 'unzip'..."
sudo apt-get update
sudo apt-get install -y unzip curl

# 5. Descargar, descomprimir e instalar dentro del directorio temporal.
echo "📥 Descargando el instalador de AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "${TEMP_DIR}/awscliv2.zip"

echo "📦 Descomprimiendo el archivo..."
unzip "${TEMP_DIR}/awscliv2.zip" -d "${TEMP_DIR}"

echo "⚙️ Ejecutando el instalador..."
sudo "${TEMP_DIR}/aws/install"

# 6. Limpiar el directorio temporal y su contenido.
echo "🧹 Limpiando archivos de instalación..."
rm -rf "${TEMP_DIR}"

# 7. Verificar la instalación y mostrar la versión.
echo "🔍 Verificación final:"
aws --version

echo "✅ ¡Instalación de AWS CLI completada con éxito!"
