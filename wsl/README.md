# GUÍA DE INSTALACIÓN

## 1. CONFIGURACIÓN DE WSL

a. Exportar la imagen de WSL
Requisito previo: Tener una imagen exportada de WSL (\*.tar) configurada con el usuario paul.

```sh
# -pr2g-laptop01-w001-win11-wsl-apps-ubuntu24
# -pr2g-laptop01-w001-win11-wsl-services-ubuntu24
# -pr2g-laptop01-w001-win11-wsl-study-apps-ubuntu24
# -pr2g-laptop01-w001-win11-wsl-study-services-ubuntu24
```


b. Importar la imagen de WSL

1. Ejecutar el siguiente comando (reemplazar <nombre_máquina> y <ruta_imagen>):

```sh
wsl --import <nombre_máquina> <directorio_destino> <ruta_imagen.tar>
```

2. Verificar la importación:

```sh
wsl -l -v
```

c. Configurar el nombre del host

```sh
sudo nano /etc/hostname /etc/hosts
```

    d. Modificar wsl.conf en base a la plantilla
    

    ```sh
    sudo nano /etc/wsl.conf
    ### 1 ###

    sudo apt-get update
    sudo apt-get install jq -y
    jq --version
    cd ~
    rm -rf ~/config_vm
    mkdir -p ~/config_vm
    cd ~/config_vm
    TOKEN_GITHUB=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
    wget  --header="Authorization: token $TOKEN_GITHUB" --header="Accept: application/vnd.github.v3.raw" https://raw.githubusercontent.com/paulgualambo/ms-vms-configure-admin/main/workspace/paul-laptop01-win11/wsl-vms.json
    wget  --header="Authorization: token $TOKEN_GITHUB" --header="Accept: application/vnd.github.v3.raw" https://raw.githubusercontent.com/paulgualambo/ms-vms-configure-admin/main/wsl/host-config.sh
    . ~/config_vm/host-config.sh "$(cat wsl-vms.json)" ".local.me" "$TOKEN_GITHUB"

    #### 2 Power shell #####
    wsl --terminate paul-laptop01-win11-wsl-w001-app
    wsl -d paul-laptop01-win11-wsl-w001-app -u paul

    #### 3 #####
    cd ~/config_vm
    TOKEN_GITHUB=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
    wget  --header="Authorization: token $TOKEN_GITHUB" --header="Accept: application/vnd.github.v3.raw" https://raw.githubusercontent.com/paulgualambo/ms-vms-configure-admin/main/wsl/pre-startup.sh

    . ~/config_vm/pre-startup.sh "$(cat wsl-vms.json)" ".w001.app" "$TOKEN_GITHUB"

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
