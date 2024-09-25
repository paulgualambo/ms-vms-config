#create directory
#mount directory

PARTITION=/dev/sda7
mkdir -p /home/${USER}/workspace

sudo mount /dev/sda7 /home/${USER}/workspace
sudo chmod -R 755 /home/${USER}/workspace
sudo chown -R ${USER}:${USER} /home/${USER}/workspace