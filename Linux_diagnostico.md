sudo apt install -y dmidecode
sudo dmidecode -t bios

lsb_release -a
uname -a
cat /proc/version

lscpu
free -h
sudo dmidecode -t memory


lspci | grep -i vga
sudo lshw -C display


sudo apt install -y lshw
sudo lshw > hardware_info.txt

ip addr show
sudo lshw -C network
sudo apt install net-tools
ifconfig -a
