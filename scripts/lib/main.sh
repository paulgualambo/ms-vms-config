# Ejecutar el segundo script para instalar software de desarrollo
USERNAME=paul
sudo wget -O - https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/config_install_software_dev.sh | bash -s -- "$USERNAME"