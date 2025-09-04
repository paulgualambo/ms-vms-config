# [ms-vms-getstart]

## Nomenclatura de nodos de trabajo

### prefix

pr2g-

### machine nodo

pc01, laptop01, mac01, disk01, notebook01

### use

personal, study, sandbox, w000, w001, w002, wxxx

-   personal -- > uso variado
-   study --> certificaciones
-   sandbox --> levantar aplicaciones temporales
-   w000 --> aplicaciones personales de proyectos (aplicaciones, pr2g-erp)
-   wxxx --> ambitos de trabajo (w001, w002, ...)
    -   w001 work now, typescript aws github jira postman confluence
    -   w002 work NET aws jira confluence postman vscode visual studio

### SO

-   windows
    -   windows11 win11

-   linux
    -   ubuntu ubuntu
    -   debian debian
    -   fedora fedora
    -   redhat rhle
    -   linux-mint lmint
    -   open suse opensuse

-   macOS
    -   sonoma msnma

### type virtualization

-   vbx: virtual box
-   vgt: vagrant
-   wsl: windows subsystem linux
-   hyv: hyper view

#### host

-   apps
-   services

## instances of nodos

### pc01

-   pr2g-pc01-personal-ubuntu
-   pr2g-pc01-study-debian
-   pr2g-pc01-w000-fedora
-   pr2g-pc01-w002-lmint
-   pr2g-pc01-sandbox-ubuntu
-   pr2g-pc01-sandbox-fedora

### laptop01

-   pr2g-laptop01-personal-win11 150

    -   pr2g-laptop01-personal-win11-wsl-apps-ubuntu24
    -   pr2g-laptop01-personal-win11-wsl-services-ubuntu24

-   pr2g-laptop01-w001-win11 200

    -   pr2g-laptop01-w001-win11-vbx-apps-ubuntu24 - 192.168.207.10
    -   pr2g-laptop01-w001-win11-vbx-services-ubuntu24
    -   pr2g-laptop01-w001-win11-vbx-study-apps-ubuntu24
    -   pr2g-laptop01-w001-win11-wsl-apps-ubuntu24
    -   pr2g-laptop01-w001-win11-wsl-services-ubuntu24
    -   pr2g-laptop01-w001-win11-vbx-study-apps-ubuntu24

        ```sh
        wsl -d pr2g-laptop01-w001-win11-wsl-study-apps-ubuntu24
        ```

    -   pr2g-laptop01-w001-win11-wsl-study-services-ubuntu24
    -   pr2g-laptop01-w001-win11-wsl-sandbox-ubuntu24

-   p2rg-laptop01-study-win11 200 (disk01)

    -   pr2g-laptop01-study-win11-wsl-apps-ubuntu24
    -   pr2g-laptop01-study-win11-wsl-services-ubuntu24

-   p2rg-laptop01-w000-ubuntu 100 (disk01)

    -   pr2g-laptop01-w000-ubuntu-vgt-apps-ubuntu24
    -   pr2g-laptop01-w000-ubuntu-vgt-services-ubuntu24
    -   pr2g-laptop01-w000-ubuntu-vgt-study-apps-ubuntu24
    -   pr2g-laptop01-w000-ubuntu-vgt-study-services-ubuntu24

-   p2rg-laptop01-w002-fedora 100 (disk01)

    -   pr2g-laptop01-w002-fedora-vgt-apps-ubuntu24
    -   pr2g-laptop01-w002-fedora-vgt-services-ubuntu24
    -   pr2g-laptop01-w002-fedora-vgt-study-apps-ubuntu24
    -   pr2g-laptop01-w002-fedora-vgt-study-services-ubuntu24

-   p2rg-laptop01-personal-fedora 100 (disk01)
    -   pr2g-laptop01-personal-fedora-vgt-study-apps-ubuntu24
    -   pr2g-laptop01-personal-fedora-vgt-study-services-ubuntu24

```sh
git config user.email paul.gualambo@gmail.com
git config user.name 'Paul Romualdo Gualambo Giraldo'

git remote remove origin
git remote add origin git@github.com:paulgualambo/m-vms-config.git
git branch -M main
git push -u origin main

#por cada maquina laptop01, pc01, ... hay un conjunto de claves
#nodo es laptop01, pc01, mac01
ssh-keygen -t ed25519 -C "paul.gualambo@gmail.com - study - personal - sandbox" -f '/home/paul/.ssh/p2rg-[nodo]-study-personal-sandbox-id-key_ed25519'

ssh-keygen -t ed25519 -C "[paul.gualambo.w000]@[w000.xxx] - w000 - pr2g-erp" -f '/home/paul/.ssh/pr2g-[nodo]-w000-id-key_ed25519'

ssh-keygen -t ed25519 -C "[paulgualambo.w001]@[w001.domain] - w001 - [name - w001]" -f 'c:/Users/paul/.ssh/pr2g-[nodo]-w001-id-key_ed25519'

ssh-keygen -t ed25519 -C "[paulgualambo.wxxx]@[wxxx-domain] - wxxx - [name - wxxx]" -f 'c:/Users/paul/.ssh/pr2g-[nodo]-wxxx-id-key_ed25519'
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

- Levantar una maquina virtual
    - Ingresar por ssh
    ```sh
         #!/bin/bash

        # Verifica si se proporcionó un nombre de host o IP como argumento
        if [ -z "$1" ]; then
        echo "Uso: $0 <hostname_o_ip>"
        exit 1
        fi

        # Guarda el argumento en una variable para mayor claridad
        HOST_A_ELIMINAR=$1

        echo "🔑 Eliminando la clave SSH para el anfitrión: $HOST_A_ELIMINAR..."

        # Ejecuta el comando para remover la clave del known_hosts
        ssh-keygen -R "$HOST_A_ELIMINAR"

        echo "✅ ¡Listo! La clave ha sido eliminada. Ya puedes conectarte de nuevo."
    ```
    -	Junto con:
	    -	Usuario user
		-   Software base
	-   creacion de workspace
        ```sh
		mkdir ~/workspace ~/workspace/apps
		cd ~/workspace && git clone git@github.com:paulgualambo/ms-vms-config.git
        ```

- En el terminal de host

```sh

#!/bin/bash
# Este sera ejecutado en gitbash que soporte comandos en Linux
# --- Configuración ---
# Define el usuario y la dirección IP aquí
REMOTE_USER="paul"
REMOTE_IP="192.168.207.20"

# --- Conexión y Copia ---
# Define la dirección de destino para mayor claridad
REMOTE_TARGET="${REMOTE_USER}@${REMOTE_IP}"

echo "🚀 Transfiriendo archivos a ${REMOTE_TARGET}..."

# Copia la llave SSH y el archivo de configuración de npm
scp -r ~/.ssh/paul* "${REMOTE_TARGET}:/home/${REMOTE_USER}/.ssh/"
scp ~/.npmrc "${REMOTE_TARGET}:/home/${REMOTE_USER}/.npmrc"

# --- Permisos ---
# Ejecuta los comandos para ajustar permisos en el servidor remoto
echo "🔐 Ajustando permisos en el servidor remoto..."
ssh "${REMOTE_TARGET}" "chmod 700 ~/.ssh && chmod 600 ~/.ssh/*"

echo "✅ ¡Proceso completado!"

ssh-copy-id -i ~/.ssh/${REMOTE_USER}-me-id-key_ed25519.pub ${REMOTE_TARGET}
```

En el mismo repositorio

```sh
#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/paulgualambo/ms-vms-config/refs/heads/main/wsl/install.sh) '{"hostname":"pr2g-laptop01-w001-win11-wsl-sandbox", "distro":"DEBIAN", "username":"paul", "email":"paul.gualambo@gmail.com", "password":"123456"}'
```
