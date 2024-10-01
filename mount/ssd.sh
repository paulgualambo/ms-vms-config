## Configure ms-vms-configure-admin

```sh
sudo mkdir -p /mnt/paul-disk01-data_shared_ext4
sudo mkdir -p /mnt/paul-laptop01-data_shared_ext4
sudo mkdir -p /mnt/paul-laptop01-data_shared_ext4/paul-disk01-data_shared_ext4/ms-vms-configure-admin
sudo mkdir -p /mnt/paul-laptop01-data_shared_ext4/paul-disk01-data_shared_ext4/workspace-w001

############### LINUX ###############
#abri sudo nano /etc/fstab
sudo blkid
sudo nano /etc/fstab
#add line
UUID=a08722a4-4aaf-4741-a4a4-0399b2a10cd9   /mnt/paul-laptop01-data_shared_ext4   ext4   nofail,x-systemd.automount,x-systemd.device-timeout=2   0   2
UUID=9c31f8a3-feed-4701-8827-46a4886b3ed8   /mnt/paul-disk01-data_shared_ext4   ext4   nofail,x-systemd.automount,x-systemd.device-timeout=2   0   2
sudo mount -a
#####################################

############### WSL ###############
# POWER SHELL
# MODO ADMIN
wsl --mount \\.\PHYSICALDRIVE1 --partition 5 --type ext4

# WSL
sudo ln -s /mnt/wsl/PHYSICALDRIVE1p5 /mnt/paul-disk01-data_shared_ext4
#####################################


## disk01 -> laptop01
sudo rsync -avzh --exclude='**/node_modules/**' --exclude='**/coverage/' --progress \
/mnt/paul-disk01-data_shared_ext4/workspaces/ms-vms-configure-admin/ \
/mnt/paul-laptop01-data_shared_ext4/paul-disk01-data_shared_ext4/ms-vms-configure-admin/

sudo rsync -avzh --exclude='**/node_modules/**' --exclude='**/coverage/' --progress \
/mnt/paul-laptop01-data_shared_ext4/paul-disk01-data_shared_ext4/ms-vms-configure-admin/ \
/mnt/paul-disk01-data_shared_ext4/workspaces/ms-vms-configure-admin/


##Eliminando los ln
sudo rm /home/paul/ms-vms-configure-admin
sudo rm /home/paul/workspace-w001
sudo rm /home/paul/data

####
## machine and virtual machine
sudo ln -s /mnt/paul-laptop01-data_shared_ext4/paul-disk01-data_shared_ext4/ms-vms-configure-admin /home/paul/
## sourcecode
sudo ln -s /mnt/paul-disk01-data_shared_ext4/workspaces/w001 /home/paul/workspace-w001
### data
sudo ln -s /mnt/paul-laptop01-data_shared_ext4/ /home/paul/data

```