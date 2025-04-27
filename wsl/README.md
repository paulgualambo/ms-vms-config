# GUÍA DE INSTALACIÓN

## 0. CREAR UNA NUEVA INSTANCIA DE WSL

a. Instalar una nueva distribución
```sh
   # windows
   # listar las versiones disponibles
   wsl --list --online
   # o su forma abreviada:
   wsl -l -o

    ##eliminando el wsl
    wsl --unregister <NombreDeTuDistribucionPersonalizada>
    #example
    wsl --unregister pr2g-laptop01-w001-win11-wsl-sandbox-ubuntu24

   #Instalacion de un distro, o descargarse una desde externamente desde ubuntu
   ##wsl --install -d Ubuntu-24.04
   https://ubuntu.com/desktop/wsl
   wsl --export Ubuntu-24.04 E:\win11\wsl\so-images\base-ubuntu2402-microsoft-base-user-paul.tar
   wsl --import <NombreDeTuDistribucionPersonalizada> <RutaDeInstalacion> <RutaDelArchivoTarGz>

   #Ejemplo   
   wsl --import pr2g-laptop01-w001-win11-wsl-sandbox-ubuntu24 E:\win11\wsl\so-instances\pr2g-laptop01-w001-win11-wsl-sandbox-ubuntu24 E:\win11\wsl\so-images\base-ubuntu-24.04.2-wsl-amd64.gz

   #Hacer un wsl temporal
   wsl --import pr2g-laptop01-w001-win11-wsl-apps-ubuntu24-temp E:\win11\wsl\so-instances\pr2g-laptop01-w001-win11-wsl-apps-ubuntu24-temp E:\win11\wsl\so-images\base-ubuntu2402-microsoft-base-user-paul.tar

   # Levantar la maquina virtual
   wsl -d <nombre_máquina>

   # Creacion de usuario
   # apt install -y jq
   # bash <(curl -s https://raw.githubusercontent.com/paulgualambo/ms-vms-config/refs/heads/main/wsl/install.sh?${RANDOM}) '{"hostname":"pr2g-laptop01-w001-win11-wsl-sandbox-ubuntu24", "distro":"DEBIAN", "username":"paul", "email":"paul.gualambo@gmail.com", "password":"123456"}'

    # Ajustes en wsl.conf
    # bash <(curl -s "https://raw.githubusercontent.com/paulgualambo/ms-vms-config/refs/heads/main/wsl/wsl-config.sh?${RANDOM}") '{"hostname":"pr2g-laptop01-w001-win11-wsl-sandbox-ubuntu24", "distro":"DEBIAN", "username":"paul", "email":"paul.gualambo@gmail.com", "password":"123456"}'

```

## 1. CONFIGURACIÓN DE WSL

a. Exportar la imagen de WSL
Requisito previo: Tener una imagen exportada de WSL (\*.tar) o gz

```sh
# -pr2g-laptop01-w001-win11-wsl-apps-ubuntu24
# -pr2g-laptop01-w001-win11-wsl-services-ubuntu24
# -pr2g-laptop01-w001-win11-wsl-study-apps-ubuntu24
# -pr2g-laptop01-w001-win11-wsl-study-services-ubuntu24
# -pr2g-laptop01-w001-win11-wsl-sandbox-ubuntu24
```


b. Importar la imagen de WSL

1. Ejecutar el siguiente comando (reemplazar <nombre_máquina> y <ruta_imagen>):

```sh
# exportar
wsl --export Ubuntu-24.04 E:\win11\wsl\so-images\pr2g-win11-wsl-ubuntu24-image.tar


2. Verificar la importación:

c. Configurar nombre de usuario y el nombre del host

```sh
sudo nano /etc/hostname 
sudo nano /etc/hosts
sudo nano /etc/wsl.conf
```

    d. Modificar wsl.conf en base a la plantilla
    

    ```sh
    ### 1 ###

    sudo apt-get update
    sudo apt-get install jq -y
    jq --version
    cd ~
    rm -rf ~/config_vm
    mkdir -p ~/config_vm
    cd ~/config_vm
    DEVICE_NAME=pr2g-laptop01
    DEVICE_INSTANCE_SO=pr2g-laptop01-w001-win11
    DEVICE_INSTANCE_SO_CREATE=.w001.wsl.study
    TOKEN_GITHUB=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
    wget  --header="Authorization: token $TOKEN_GITHUB" --header="Accept: application/vnd.github.v3.raw" https://raw.githubusercontent.com/paulgualambo/ms-vms-configure-admin/main/workspace/${DEVICE_NAME}/vms.json

    #### 2 Power shell #####
    # wsl --terminate paul-laptop01-win11-wsl-w001-app
    # wsl -d paul-laptop01-win11-wsl-w001-app -u paul

    #### 3 #####
    cd ~/config_vm
    wget  --header="Authorization: token $TOKEN_GITHUB" --header="Accept: application/vnd.github.v3.raw" https://raw.githubusercontent.com/paulgualambo/ms-vms-configure-admin/main/wsl/pre-startup.sh
    . ~/config_vm/pre-startup.sh "$(cat vms.json)" "$DEVICE_INSTANCE_SO_CREATE" "$TOKEN_GITHUB"

    ```

    d. revisar los hostname y la ip
    e. install software basico y adicionales con pre-startup.sh
    f. Probar si se alzanza estos endpoints

    ```sh

    source ~/.bashrc
    ssh -T git@bitbucket.org
    ssh -T git@github.com
    ssh -T git@gitlab.com
    ```
    g. install software app startup.sh
    h. configure repositorio basico

2. ./install.sh
3. ./startup.sh
