# Obtener el JSON como argumento
json_input="$1"

# Verificar si se pasó un argumento
if [ -z "$json_input" ]; then
  echo "Por favor, proporciona un JSON como argumento."
  exit 1
fi

# Extraer valores del JSON utilizando jq
USERNAME=$(echo $json_input | jq -r '.USERNAME // "paul"')
EMAIL=$(echo $json_input | jq -r '.EMAIL // "paul.gualambo@gmail.com"')
FULLNAME=$(echo $json_input | jq -r '.FULLNAME // "paul romualdo gualambo giraldo"')

#git Global
git config --global user.email "$EMAIL"
git config --global user.name "$FULLNAME"

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
git config --global core.editor "~/config_vm/git-choose-editor.sh"

echo '' >> ~/.bashrc

#creacion de carpeta
mkdir -p ~/workspace

#brindando permisos a la carpeta backup
# sudo mkdir -p /backup
# sudo chown $USERNAME:$USERNAME /backup
# sudo cp -R /backup/* /home/$USERNAME/workspace/

#workspace
sudo mkdir -p /home/$USERNAME/workspace/projects /home/$USERNAME/workspace/data
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/workspace/

# cd /home/$USERNAME/workspace/
# GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git clone git@bitbucket.org:paulgualambo/wxxx-common.git

# habilitar crontab -e
# copiar al final  "* * * * * /home/paul/config_vm/backup.sh" ejecución a cada minuto
# https://github.com/paulgualambo/git-tool/blob/main/config_account.sh
# https://bitbucket.org/account/settings/ssh-keys/
# https://github.com/settings/keys
# https://gitlab.com/-/user_settings/ssh_keys

# Proyecto generico que tiene utilitarios
# git clone git@bitbucket.org:paulgualambo/wxxx-common.git
sudo groupadd docker
sudo usermod -aG docker $USER

# Recargar el archivo de configuración para aplicar los cambios
source ~/.bashrc