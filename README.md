# [vms-getstart]

## Nomenclatura de nodos de trabajo

### prefix

pr2g-

### machine

pc01, laptop01, mac01, disk01

### use

personal, study, sandbox, w000, w001, w002, wxxx
- personal -- > uso variado
- study --> certificaciones
- sandbox --> levantar aplicaciones temporales
- w000 --> aplicaciones personales de proyectos
- wxxx --> ambitos de trabajo

### SO

- windows
  - windows11 win11

- linux
  - ubuntu      ubuntu
  - debian      debian
  - fedora      fedora
  - redhat      rhle
  - linux-mint  lmint
  - open suse   opensuse

- macOS
  - sonoma   msnma  

### type virtualization

- vtb
- wsl
- hyv

#### host

- apps
- services

## instances

### pc01

- pr2g-pc01-personal-ubuntu
- pr2g-pc01-study-debian
- pr2g-pc01-w000-fedora
- pr2g-pc01-w002-lmint
- pr2g-pc01-sandbox-ubuntu
- pr2g-pc01-sandbox-fedora

### laptop01

- pr2g-laptop01-personal-win11
- pr2g-laptop01-w001-win11
- p2rg-laptop01-study-win11
- p2rg-laptop01-w000-ubuntu
- p2rg-laptop01-w002-fedora
- p2rg-laptop01-personal-fedora

```sh
git config user.email paul.gualambo@gmail.com
git config user.name 'Paul R. Gualambo Giraldo'

git remote remove origin
git remote add origin git@github.com:paulgualambo/m-vms-config.git
git branch -M main
git push -u origin main

ssh-keygen -t ed25519 -C "paul.gualambo@gmail.com - study - personal - sandbox" -f 'c:/Users/paul/.ssh/paul-sps-id-key_ed25519'
ssh-keygen -t ed25519 -C "paul.gualambo.w000@gmail.com - w000 - [name - w000]" -f 'c:/Users/paul/.ssh/paul-w000-id-key_ed25519'
ssh-keygen -t ed25519 -C "paulgualambo@[w001-domain] - w001 - [name - w001]" -f 'c:/Users/paul/.ssh/paul-w001-id-key_ed25519'
ssh-keygen -t ed25519 -C "paul.gualambo@[w002-domain] - w002 - [name - w002]" -f 'c:/Users/paul/.ssh/paul-w002-id-key_ed25519'
```

```sh
#Convertir todos los archivos a formato Unix
sudo apt install dos2unix
for file in *; do
    if [ -f "$file" ]; then
        dos2unix "$file"
    fi
done
find . -type f -exec dos2unix {} \;
```

1.- Creacion de usuario y brindales los permisos de sudo
2. Reinstalar el GRUB desde Red Hat (opcional)
Si prefieres que el GRUB de Red Hat sea el que controle el arranque, puedes reinstalarlo. Para esto:

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
