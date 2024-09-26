# INSTALL

    1. CONFIGURE WSL

    a. Tener un export de wsl (image), ya esta con el usuario "paul"
    b. Realizar un import de wsl se cambiara el nombre de la maquina
    c. Configurar el nombre del host, se realizara cambiando el 
        /etc/hostname, /etc/hosts y /etc/resolv.conf haciendo el sudo hostname

    ```sh
    # HOSTNAME_NEW="paul-laptop01-win11-wsl-ubuntu"
    # sudo sed -i "s/paul-laptop01-win/$HOSTNAME_NEW/g" /etc/hostname
    # sudo sed -i "s/paul-laptop01-win/$HOSTNAME_NEW/g" /etc/hosts
    # sudo hostname "$HOSTNAME_NEW"

    # sudo vim /etc/hostname
    # sudo vim /etc/hosts
    
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
