sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install git -y

# Ejecutar el segundo script para instalar basico
USERNAME="paul"
sudo wget -O - https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/config_install_software_dev_rhel.sh | bash -s -- "$USERNAME"

source ~/.bashrc
