#Install chrome
#Install vscode
sudo dnf install git -y

# sync files with paul-diskxx
sudo mkdir -p /mnt/paul-disk01
sudo chown paul:paul -R /mnt/paul-disk01

#Desmontar el disco, ubicandolo en la machine
sudo blkid
# x/dev/sdb1: LABEL="paul-disk01" UUID="B502-636C" BLOCK_SIZE="512" TYPE="exfat" PARTUUID="1652e139-01"
# Add this line en sudo nano /etc/fstab
UUID=B502-636C /mnt/paul-disk01 exfat defaults,uid=1000,gid=1000,umask=002 0 2

git config user.email paul.gualambo@gmail.com
git config user.name 'Paul R. Gualambo Giraldo'

#WSL
sudo mkdir -p /mnt/paul-disk01
sudo mount -t drvfs P: /mnt/paul-disk01 -o uid=1000,gid=1000,fmask=002,dmask=002
sudo mount -t drvfs P: /mnt/paul-disk01 -o uid=1002,gid=1002,fmask=0022,dmask=0022



## SSD
## DESDE MACHINE O VIRTUAL MACHINE HACIA DISCO EXTERNO nuevo paul gualambo
mkdir -p ~/workspace/w001
sudo rsync -avzh --exclude='**/node_modules/**' --exclude='**/coverage/' --progress /mnt/paul-disk01/workspaces/w001/ /home/paul/workspace/w001/
sudo rsync -avzh --exclude='**/node_modules/' --exclude='**/coverage/' --delete --progress /home/paul/workspace/w001/ /mnt/paul-disk01/workspaces/w001/

sudo rsync -avzh --exclude='**/node_modules/' --exclude='**/coverage/' --delete --progress /home/paul/workspace/w001/ /mnt/paul-disk01/workspaces/w001/


#copy ssh from paul-disk01 to machine or virtual-machine
mkdir -p ~/.ssh
chmod 600 ~/.ssh/paul-*

#workspace
mkdir -p ~/paul-disk01


#Add .bashrc to add ssh in terminal
echo -e '\n# Iniciar el agente SSH\n' >> ~/.bashrc
echo 'eval "$(ssh-agent -s)"' >> ~/.bashrc
echo -e '\n# Agregar todas las claves SSH que coincidan con el patrón\n' >> ~/.bashrc
echo "for key in ~/.ssh/\${USER}-*-id-key_ed25519; do" >> ~/.bashrc
echo '    ssh-add "$key" ' >> ~/.bashrc
echo 'done' >> ~/.bashrc
echo 'echo "All SSH keys have been added successfully."' >> ~/.bashrc

# Ejecutar el segundo script para instalar software de desarrollo
sudo wget -O - https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/config_install_software_dev_rhel.sh | bash -s -- "$USERNAME"

sudo dnf install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
docker --version
newgrp docker
sudo usermod -aG docker $USER



source ~/.bashrc