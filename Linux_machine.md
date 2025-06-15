Indice
Configuración inicial del sistema
Actualización del sistema
Instalación de controladores gráficos
Configuración de monitores
Instalación de herramientas de desarrollo
Instalación de .NET SDK
Instalación de Node.js y TypeScript
Instalación de AWS CLI y SDK
Instalación de Docker
Configuración del entorno de desarrollo
Instalación de un IDE o editor de código
Configuración del terminal
Gestión de versiones con Git
Optimización del sistema
Mejora del rendimiento
Personalización y productividad
Buenas prácticas y mantenimiento


## Configuración inicial del sistema

### Actualización del sistema

Tener el sistema actualizado

```sh
    ## Ubuntu, debian, Kali
    sudo apt update -y && sudo apt list --upgradable && sudo apt upgrade -y && sudo apt autoremove -y

    ## Redhat Fedora

    ## Opensuse

    ## ArchLinux

```

### Instalación de controladores gráficos

```sh
    ## Ubuntu, debian, Kali
    ubuntu-drivers devices
    sudo ubuntu-drivers autoinstall


    ## Redhat Fedora

    ## Opensuse

    ## ArchLinux

```

### Software base instalación

- Linux
    - gparted
    - chrome
    - vscode
    - postman

### Personalización del workspace

- gnome-tweaks

### Configuración de los tres monitores


### Automount de folders

```sh
#Creacion de la carpeta
## Esto es en la misma pc01
sudo mkdir -p /mnt/pr2g-pc01-data-shared-ext4
sudo mkdir -p /mnt/{prefix}-{machine}-{use}-data

sudo mkdir -p /mnt/pr2g-pc01-study-data
##Automontado pasos para su realización
lsblk -f
sudo blkid
sudo nano /etc/fstab
UUID=7b031077-54a4-4a53-b696-439fb326c520 /mnt/pr2g-pc01-data-shared-ext4 ext4 defaults 0 2

#UUID=7b031077-54a4-4a53-b696-439fb326c520 /mnt/{prefix}-{machine}-{use}-data ext4 defaults 0 2
sudo mount -a
systemctl daemon-reload
#df -h | grep /mnt/{prefix}-{machine}-{use}-data
df -h | grep /mnt/pr2g-pc01-data-shared-ext4

## example
```
