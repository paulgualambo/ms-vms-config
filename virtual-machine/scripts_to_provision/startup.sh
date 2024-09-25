#se ejecuta con el perfil del programador
USERNAME="paul"
EMAIL=paul.gualambo@gmail.com
FULLNAME='paul romualdo gualambo giraldo'

#git Global
git config --global user.email "$EMAIL"
git config --global user.name "$FULLNAME"

# Ejecutar el segundo script para instalar software de desarrollo
sudo wget -O - https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/config_install_software_dev.sh | bash -s -- "$USERNAME"

#Add .bashrc
echo -e '\n' >> ~/.bashrc
echo 'eval "$(ssh-agent -s)"' >> ~/.bashrc
echo 'ssh-add ~/.ssh/id_ed25519' >> ~/.bashrc
echo -e '\n' >> ~/.bashrc

#mejora del git 
echo '# Alias de Git' >> ~/.bashrc
echo 'git config --global alias.st "status"' >> ~/.bashrc
echo 'git config --global alias.lg "log --oneline --graph --all"' >> ~/.bashrc
echo 'git config --global alias.hist "log --pretty=format:'"'%h %ad | %s%d [%an]'"' --graph --date=short"' >> ~/.bashrc
echo 'git config --global alias.a "add ."' >> ~/.bashrc
echo 'git config --global alias.cm "commit -m"' >> ~/.bashrc
echo 'git config --global alias.br "branch"' >> ~/.bashrc
echo 'git config --global alias.co "checkout"' >> ~/.bashrc
echo 'git config --global alias.cb "checkout -b"' >> ~/.bashrc
echo 'git config --global alias.mg "merge"' >> ~/.bashrc
echo 'git config --global alias.rb "branch -d"' >> ~/.bashrc
echo 'git config --global alias.pl "pull"' >> ~/.bashrc
echo 'git config --global alias.ps "push"' >> ~/.bashrc
echo 'git config --global alias.unstage "reset HEAD"' >> ~/.bashrc
echo 'git config --global alias.s "stash"' >> ~/.bashrc
echo 'git config --global alias.sp "stash pop"' >> ~/.bashrc
echo 'git config --global alias.ri "rebase -i"' >> ~/.bashrc

# Configurar VS Code como editor predeterminado
git config --global core.editor "code --wait"

# Crear el script de shell para seleccionar el editor
touch ~/config_vm/git-choose-editor.sh

# Editar el script
echo '#!/bin/sh
if command -v code >/dev/null 2>&1; then
  code --wait "$@"
else
  vim "$@"
fi' > ~/config_vm/git-choose-editor.sh

# Hacer el script ejecutable
chmod +x ~/config_vm/git-choose-editor.sh

# Configurar Git para usar el script como editor
git config --global core.editor "~/choose-editor.sh"

echo '' >> ~/.bashrc

#creacion de carpeta
mkdir -p ~/workspace

#brindando permisos a la carpeta backup
sudo mkdir -p /backup
sudo chown $USERNAME:$USERNAME /backup
sudo cp -R /backup/* /home/$USERNAME/workspace/
sudo mkdir -p /home/$USERNAME/workspace/projects /home/$USERNAME/workspace/data
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/workspace/

cd /home/$USERNAME/workspace/projects
GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git clone git@bitbucket.org:paulgualambo/wxxx-common.git

# Recargar el archivo de configuración para aplicar los cambios
source ~/.bashrc

# habilitar crontab -e
# copiar al final  "* * * * * /home/paul/config_vm/backup.sh" ejecución a cada minuto
# https://github.com/paulgualambo/git-tool/blob/main/config_account.sh
# https://bitbucket.org/account/settings/ssh-keys/
# https://github.com/settings/keys
# https://gitlab.com/-/user_settings/ssh_keys

# Proyecto generico que tiene utilitarios
# git clone git@bitbucket.org:paulgualambo/wxxx-common.git
