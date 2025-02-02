MACHINE_PATH

# Alias
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

##laptop-01
sync_d01_local() {
    sudo rsync -avzh --exclude="**/node_modules/**" --exclude="**/coverage/" --progress --update /mnt/paul-disk01-data_shared_ext4/workspaces/ms-vms-configure-admin/ /mnt/paul-laptop01-data_shared_ext4/paul-disk01-data_shared_ext4/ms-vms-configure-admin/
    sudo rsync -avzh --exclude="**/node_modules/**" --exclude="**/coverage/" --progress --update /mnt/paul-disk01-data_shared_ext4/workspaces/w001/ /mnt/paul-laptop01-data_shared_ext4/paul-disk01-data_shared_ext4/workspace-w001/
    sudo rsync -avzh --exclude='**/node_modules/**' --exclude='**/coverage/' --progress --update /mnt/paul-laptop01-data_shared_ext4/paul-disk01-data_shared_ext4/ms-vms-configure-admin/ /mnt/paul-disk01-data_shared_ext4/workspaces/ms-vms-configure-admin/
    sudo rsync -avzh --exclude='**/node_modules/**' --exclude='**/coverage/' --progress --update /mnt/paul-laptop01-data_shared_ext4/paul-disk01-data_shared_ext4/workspace-w001/ /mnt/paul-disk01-data_shared_ext4/workspaces/w001/
}

##pc-01
sync_d01_local() {
    sudo rsync -avzh --exclude="**/node_modules/**" --exclude="**/coverage/" --progress --update /mnt/paul-disk01-data_shared_ext4/workspaces/ms-vms-configure-admin/ /mnt/paul-pc01-data_shared_ext4/paul-disk01-data_shared_ext4/ms-vms-configure-admin/
    sudo rsync -avzh --exclude="**/node_modules/**" --exclude="**/coverage/" --progress --update /mnt/paul-disk01-data_shared_ext4/workspaces/w001/ /mnt/paul-pc01-data_shared_ext4/paul-disk01-data_shared_ext4/workspace-w001/
    sudo rsync -avzh --exclude='**/node_modules/**' --exclude='**/coverage/' --progress --update /mnt/paul-pc01-data_shared_ext4/paul-disk01-data_shared_ext4/ms-vms-configure-admin/ /mnt/paul-disk01-data_shared_ext4/workspaces/ms-vms-configure-admin/
    sudo rsync -avzh --exclude='**/node_modules/**' --exclude='**/coverage/' --progress --update /mnt/paul-pc01-data_shared_ext4/paul-disk01-data_shared_ext4/workspace-w001/ /mnt/paul-disk01-data_shared_ext4/workspaces/w001/
}

