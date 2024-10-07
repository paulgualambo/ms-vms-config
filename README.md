# [vms-getstart]

## distribución

prefix
paul-

Machine
pc01, laptop01, mac01

s0
windows 11   win11
linux
    ubuntu   ubuntu
    debian   debian
    fedora   fedora
    redhat   rhle
    linux-mint  lmint

macOS
    Sonoma   msnma  

--type virtualization
vgt, wsl, hyv

--group
w001, w002, study, sandbox

--host
apps services 

paul-pc01-ubuntu
paul-pc01-fedora
paul-laptop01-win11
paul-laptop01-win11-wsl-sandbox-app
paul-laptop01-win11-wsl-study-app
paul-laptop01-win11-wsl-sandbox-app
paul-laptop01-lkl
paul-laptop01-lkl-vgt-sandbox-app
paul-laptop01-lfd-vgt-sandbox-app

study --> certificaciones
sandbox --> levantar aplicaciones temporales
w000 --> aplicaciones personales
wxxx

#Linux
Hacer upgrade a todo
Install git
sudo apt install git -y
Install chrome
Install vscode


Register .ssh
Ejecutar script
    startup_rhel_rpm.sh
    startup_debian_deb.sh

```sh
git config user.email paul.gualambo@gmail.com
git config user.name 'Paul R. Gualambo Giraldo'

git remote remove origin
git remote add origin git@github.com:paulgualambo/m-vms-config.git
git branch -M main
git push -u origin main

#UBUNTU


## git
sudo apt update
sudo apt install git -y
git --version

#VIRTUAL BOX
sudo apt-get update
sudo apt-get install virtualbox
VBoxManage --version

#VAGRANT
sudo apt-get update
sudo apt-get install vagrant
sudo apt autoremove -y

```

Creacion de ssh

### paul-laptop01
personal
study
sandbox
comunicacion entre vm, wsl, hp


```
#personal -> me, stype, sandbox
#w001
#w002

ssh-keygen -t ed25519 -C "paul.gualambo@gmail.com - study - sandbox - personal" -f 'c:/Users/paul/.ssh/paul-laptop01-me-id-key_ed25519'

ssh-keygen -t ed25519 -C "paulgualambo@[w001-domain] - w001 - [name - w001]" -f 'c:/Users/paul/.ssh/paul-laptop01-w001-id-key_ed25519'

ssh-keygen -t ed25519 -C "paul.gualambo@[w002-domain] - w002 - [name - w002]" -f 'c:/Users/paul/.ssh/paul-laptop01-w002-id-key_ed25519'

```

ssh-add C:\Users\paul\.ssh\paul-laptop01-me-id-key_ed25519
ssh-add C:\Users\paul\.ssh\paul-laptop01-w001-id-key_ed25519
ssh-add C:\Users\paul\.ssh\paul-laptop01-w002-id-key_ed25519



2. Reinstalar el GRUB desde Red Hat (opcional)
Si prefieres que el GRUB de Red Hat sea el que controle el arranque, puedes reinstalarlo. Para esto:

Arranca tu laptop utilizando un Live USB de RHEL.

Abre una terminal y monta las particiones de Red Hat:

Monta la partición principal:
bash
Copiar código
sudo mount /dev/sdXY /mnt
(Cambia /dev/sdXY por la partición de Red Hat, por ejemplo /dev/sda1).

Monta las particiones adicionales si tienes /boot o /boot/efi separados:
bash
Copiar código
sudo mount /dev/sdXZ /mnt/boot
sudo mount /dev/sdXW /mnt/boot/efi
Luego reinstala GRUB en el disco:

bash
Copiar código
sudo grub2-install --root-directory=/mnt /dev/sdX
(Reemplaza /dev/sdX con el disco donde deseas instalar GRUB, por ejemplo /dev/sda).

Finalmente, actualiza la configuración de GRUB desde RHEL:

bash
Copiar código
sudo chroot /mnt
grub2-mkconfig -o /boot/grub2/grub.cfg
Reinicia la laptop. Ahora deberías ver el GRUB de RHEL y poder cargar ambos sistemas operativos.




Pasos a seguir:
Crear un Live USB de RHEL:

Descarga una imagen ISO de RHEL y crea un Live USB utilizando herramientas como dd o Rufus.
Arrancar desde el Live USB:

Inserta el Live USB en tu laptop y arranca desde él seleccionándolo en el menú de arranque de tu BIOS/UEFI.
Montar las particiones de RHEL:

Abre una terminal en el entorno Live y monta las particiones necesarias de tu instalación de RHEL. Reemplaza /dev/sdXY con la partición correspondiente a RHEL (por ejemplo, /dev/sda2):
bash
Copiar código
sudo mount /dev/sdXY /mnt
Si tienes particiones separadas para /boot o /boot/efi, móntalas también:
bash
Copiar código
sudo mount /dev/sdXZ /mnt/boot
sudo mount /dev/sdXW /mnt/boot/efi
Reinstalar GRUB:

Ejecuta el siguiente comando para reinstalar GRUB en el disco deseado (reemplaza /dev/sdX con tu disco principal, por ejemplo, /dev/sda):
bash
Copiar código
sudo grub2-install --root-directory=/mnt /dev/sdX
Generar la configuración de GRUB:

Chroot al sistema montado:
bash
Copiar código
sudo chroot /mnt
Genera la nueva configuración de GRUB:
bash
Copiar código
grub2-mkconfig -o /boot/grub2/grub.cfg
Sal del entorno chroot:
bash
Copiar código
exit
Desmontar las particiones y reiniciar:

Desmonta todas las particiones montadas:
bash
Copiar código
sudo umount /mnt/boot/efi
sudo umount /mnt/boot
sudo umount /mnt
Reinicia tu laptop:
bash
Copiar código
sudo reboot
4. Verificar la Integridad del Kernel
Si después de seguir los pasos anteriores RHEL aún no arranca correctamente, es posible que el kernel esté dañado. En este caso, considera reinstalar RHEL o restaurar desde una copia de seguridad si tienes una disponible.

Consejos Adicionales:
Backup de Configuraciones: Antes de realizar cambios significativos en el gestor de arranque, es recomendable hacer una copia de seguridad de las configuraciones actuales de GRUB.

Comprobación de Particiones: Asegúrate de que las particiones de RHEL no hayan sido modificadas o eliminadas accidentalmente.

Actualizaciones del Sistema: Mantén tanto Ubuntu como RHEL actualizados para evitar conflictos y asegurar que ambos sistemas operativos funcionen correctamente con las últimas versiones de GRUB.

Espero que estos pasos te ayuden a resolver el problema con GRUB y a poder arrancar correctamente tanto Ubuntu como RHEL en tu laptop. Si encuentras alguna dificultad durante el proceso, no dudes en proporcionarme más detalles para poder asistirte mejor.


