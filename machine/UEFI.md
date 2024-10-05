# UEFI

UEFI (Unified Extensible Firmware Interface) soporte para particiones grandes y una interfaz grafica en el arranque

MBR y GPT son tablas de particiones

GUID Partition Table, soporta muchas particiones y discos grandes, se usa con UEFI

Usar UEFI en formato GPT maximizar la compatibilidad Windows y Linux

## Windows

win+R escribir msinfo32 Enter
Buscar Modo de Bios, se visualiza UEFI o Legacy Boot

MBR o GPT
Windows + X (Manager disk)
propiedades en el disco, volumenes, estilo de la partición

## Linux

```sh
[ -d /sys/firmware/efi ] && echo "UEFI" || echo "Legacy"
```

MBR o GPT

```sh
sudo fdisk -l
```
Disk /dev/nvme0n1: 953.87 GiB, 1024209543168 bytes, 2000409264 sectors
Disk model: KBG50ZNV1T02 KIOXIA                     
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 24045028-6FDA-4DC7-8AE2-E443C0D428CC

Device              Start        End   Sectors   Size Type
/dev/nvme0n1p1       2048     206847    204800   100M EFI System
/dev/nvme0n1p2     206848     239615     32768    16M Microsoft reserved
/dev/nvme0n1p3     239616  419670015 419430400   200G Microsoft basic data
/dev/nvme0n1p4  419670016  482170879  62500864  29.8G Linux swap
/dev/nvme0n1p5  482170880  691886079 209715200   100G Linux filesystem
/dev/nvme0n1p6  691886080  901601279 209715200   100G Linux root (x86-64)
/dev/nvme0n1p7  901601280 1321031679 419430400   200G Linux filesystem
/dev/nvme0n1p8 1998833664 2000406527   1572864   768M Windows recovery environment
/dev/nvme0n1p9 1321031680 1998833663 677801984 323.2G Microsoft basic data


## GRUB (Grand Unified Bootloader)

GRUB es el gestor de arranque, para gestionar sistemas operativos multiples, otro es el Dual boot
Particiones recomendades para linux
raiz /
Home /home
swap

## Administracion GRUB 

Si windows sobreescribe el gestor de arranque, utilizando un Live USB y ejecutar el comando "grub-install"

usar el comando

```sh

# Para detectar cualquier cambio en los sistemas operativos disponibles
sudo update-grub

```

## Restaurar Windows Bootloader:

Usar Windows Boot Manager DVD/USB del instalador de windows

Abrir la consola
```sh
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd

```

## Herramientas adicionales

BootRepair
EasyBCD

## Analisis, Diagnostico e Informe

Resumen de pasos:
Verificar particiones con lsblk o fdisk.
Revisar configuración de GRUB con cat /etc/default/grub y update-grub.
Verificar orden de arranque UEFI con efibootmgr.
Revisar logs de arranque con journalctl.
Generar un informe con Boot Info Script o Boot-Repair.
Respaldar configuraciones importantes antes de realizar cambios.

Para tener una mejor comprension de como esta estructurado el sistema de arranque


### 1. Revisión del esquema de particiones y sistemas operativos instalados
Primero, verifica el esquema de particiones de tu disco y los sistemas operativos que están instalados

sudo lsblk -f
NAME        FSTYPE FSVER LABEL            UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
nvme0n1                                                                                       
├─nvme0n1p1 vfat   FAT16                  BFE0-4EB7                               9.1M    91% /boot/efi
├─nvme0n1p2                                                                                   
├─nvme0n1p3 ntfs         Win11            01DB0C371CB7E530                                    
├─nvme0n1p4 swap   1                      a114eb0f-d869-4701-9d1e-ee784fd00c65                [SWAP]
├─nvme0n1p5 ext4   1.0   Ubuntu           d8be9f94-a44b-40fa-b635-653b71e4af26                
├─nvme0n1p6 ext4   1.0   Fedora           017eef6d-4915-4c68-97a5-dd18b126914a   74.4G    19% /
├─nvme0n1p7 ext4   1.0   data_shared_ext4 a08722a4-4aaf-4741-a4a4-0399b2a10cd9                
├─nvme0n1p8                                                                                   
└─nvme0n1p9 ntfs         data_shared_ntfs 71D6DFA56005E15F 

sudo fdisk -l
Disk /dev/nvme0n1: 953.87 GiB, 1024209543168 bytes, 2000409264 sectors
Disk model: KBG50ZNV1T02 KIOXIA                     
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 24045028-6FDA-4DC7-8AE2-E443C0D428CC

Device              Start        End   Sectors   Size Type
/dev/nvme0n1p1       2048     206847    204800   100M EFI System
/dev/nvme0n1p2     206848     239615     32768    16M Microsoft reserved
/dev/nvme0n1p3     239616  419670015 419430400   200G Microsoft basic data
/dev/nvme0n1p4  419670016  482170879  62500864  29.8G Linux swap
/dev/nvme0n1p5  482170880  691886079 209715200   100G Linux filesystem
/dev/nvme0n1p6  691886080  901601279 209715200   100G Linux root (x86-64)
/dev/nvme0n1p7  901601280 1321031679 419430400   200G Linux filesystem
/dev/nvme0n1p8 1998833664 2000406527   1572864   768M Windows recovery environment
/dev/nvme0n1p9 1321031680 1998833663 677801984 323.2G Microsoft basic data

Partition table entries are not in disk order.

### Comprobación del gestor de arranque (GRUB)

cat /etc/default/grub

GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="resume=UUID=a114eb0f-d869-4701-9d1e-ee784fd00c65 rhgb quiet"
GRUB_DISABLE_RECOVERY="true"
GRUB_ENABLE_BLSCFG=true

GRUB_DEFAULT: Indica el sistema operativo por defecto.
GRUB_TIMEOUT: Indica el tiempo de espera antes de que arranque el sistema predeterminado.
GRUB_CMDLINE_LINUX: Parámetros adicionales que se pasan al kernel de Linux.

cat /boot/grub/grub.cfg

sudo efibootmgr

BootCurrent: 0000
Timeout: 5 seconds
BootOrder: 0000,0000,0003,2001,0001,3000,2002,2004
Boot0000* Fedora	HD(1,GPT,f9d5c6a1-416a-4b3d-9633-886285a09cb1,0x800,0x32000)/\EFI\fedora\shim.efiRC
Boot0001* Windows Boot Manager	HD(1,GPT,f9d5c6a1-416a-4b3d-9633-886285a09cb1,0x800,0x32000)/\EFI\Microsoft\Boot\bootmgfw.efiRC
Boot0002* ubuntu	HD(1,GPT,f9d5c6a1-416a-4b3d-9633-886285a09cb1,0x800,0x32000)/\EFI\ubuntu\shimx64.efiRC
Boot0003* ubuntu	HD(1,GPT,50e98fc0-f37e-4267-8755-e1c13927891e,0x800,0x96000)/\EFI\ubuntu\shimx64.efiRC
Boot0004* ubuntu	HD(1,GPT,50e98fc0-f37e-4267-8755-e1c13927891e,0x800,0x96000)/\EFI\ubuntu\shimx64.efi
Boot0005* ubuntu	HD(1,GPT,f9d5c6a1-416a-4b3d-9633-886285a09cb1,0x800,0x32000)/\EFI\ubuntu\shimx64.efi
Boot0006* Windows Boot Manager	HD(1,GPT,f9d5c6a1-416a-4b3d-9633-886285a09cb1,0x800,0x32000)/\EFI\Microsoft\Boot\bootmgfw.efi57494e444f5753000100000088000000780000004200430044004f0042004a004500430054003d007b00390064006500610038003600320063002d0035006300640064002d0034006500370030002d0061006300630031002d006600330032006200330034003400640034003700390035007d00000000000100000010000000040000007fff0400
Boot0007* Red Hat Enterprise Linux	HD(1,GPT,f9d5c6a1-416a-4b3d-9633-886285a09cb1,0x800,0x32000)/\EFI\redhat\shimx64.efi
Boot0008* Fedora	HD(1,GPT,f9d5c6a1-416a-4b3d-9633-886285a09cb1,0x800,0x32000)/\EFI\fedora\shimx64.efi
Boot0009* redhat	HD(1,GPT,f9d5c6a1-416a-4b3d-9633-886285a09cb1,0x800,0x32000)/\EFI\redhat\shimx64.efi
Boot000A* kali	HD(1,GPT,50e98fc0-f37e-4267-8755-e1c13927891e,0x800,0x96000)/\EFI\kali\grubx64.efi
Boot2001* EFI USB Device	RC
Boot3000* Internal Hard Disk or Solid State Disk	RC

Eliminar las entradas

sudo efibootmgr -b 0003  -B
sudo efibootmgr -b 0004  -B
sudo efibootmgr -b 0005  -B
sudo efibootmgr -b 0006  -B
sudo efibootmgr -b 0007  -B
sudo efibootmgr -b 0008  -B
sudo efibootmgr -b 000A  -B
sudo efibootmgr -b 0009  -B

sudo efibootmgr -o 0000,0001,2001,3000

BOOTIA32.CSV y BOOTX64.CSV: Estos archivos .CSV (Comma-Separated Values) suelen contener configuraciones o parámetros que las versiones de GRUB utilizan para identificar los binarios correctos a cargar según la arquitectura (32 bits o 64 bits).

gcdia32.efi y gcdx64.efi: Estos son binarios EFI (Extensible Firmware Interface) del gestor de arranque GRUB (en 32 y 64 bits, respectivamente). Los archivos .efi son ejecutables usados por el firmware UEFI para arrancar el sistema operativo o el gestor de arranque.

grub.cfg: Este archivo contiene la configuración del menú de GRUB. Define las entradas del menú de arranque, las opciones de arranque para cada sistema operativo detectado y otros parámetros necesarios durante el arranque.

grubia32.efi y grubx64.efi: Son las versiones específicas de GRUB que se ejecutan en entornos UEFI de 32 bits (grubia32.efi) y 64 bits (grubx64.efi). Estas versiones son las que se cargan al arrancar la máquina en modo UEFI.

mmia32.efi y mmx64.efi: Los archivos mmia32.efi y mmx64.efi corresponden al MokManager (Machine Owner Key Manager), que permite gestionar claves para Secure Boot. Estos archivos están disponibles tanto para 32 bits como para 64 bits.

shimia32.efi y shimx64.efi: Estos son binarios del shim bootloader. Shim es un cargador intermedio que facilita la ejecución de GRUB en sistemas con Secure Boot habilitado. Shim está firmado con una clave conocida por UEFI y permite cargar GRUB (que no está firmado por UEFI) sin generar errores de seguridad. Estos archivos están presentes para sistemas de 32 bits (shimia32.efi) y 64 bits (shimx64.efi).


Prioridades en los binarios de GRUB: Fedora, como otras distribuciones, puede preferir un archivo EFI específico como gcdx64.efi porque este archivo puede estar configurado para gestionar ciertas características del arranque, como gráficos específicos (GRUB with Graphics Console Driver) o manejo de Secure Boot. grubx64.efi es el gestor de arranque general, mientras que gcdx64.efi puede ser una versión modificada o personalizada para funcionar con UEFI en tu máquina.

Secure Boot: En sistemas con Secure Boot, a menudo se utiliza shimx64.efi para cargar una versión de GRUB que sea compatible con las restricciones de seguridad de UEFI. Esta versión puede estar enlazada o empaquetada en gcdx64.efi, lo que podría explicar por qué se elige este archivo en lugar de grubx64.efi.

lsblk
/dev/nvme0n1 p6

sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 --loader /EFI/fedora/grubx64.efiRC --label "Fedora WS"

sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 --loader /EFI/Microsoft/Boot/bootmgfw.efi --label "Windows Boot Manager"

sudo efibootmgr -b 0000  -B
sudo efibootmgr -b 0003  -B
sudo efibootmgr -b 0004  -B
sudo efibootmgr -b 0005  -B
sudo efibootmgr -b 0006  -B

Especificar el dispositivo
GRUB_DEVICE=/dev/nvme0n1

sudo grub-install /dev/nvme0n1 --target=x86_64-efi --efi-directory=/boot/efi/

continuar con el tema de grub y efi
https://chatgpt.com/c/66f947d7-0f98-8006-bbbe-36f1b2595fdc
