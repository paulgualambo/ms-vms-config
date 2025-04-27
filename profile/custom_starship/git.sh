#!/bin/bash

# [custom.profile]
# command = "~/.config/custom_starship/git_user.sh"
# description = "Muestra la descripcion del prompt"
# when = "true"
# style = "bold"


if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    # Obtener el correo del usuario configurado en git
    git_email=$(git config --get user.email || git config --global --get user.email)

    # Verificar si hay un correo configurado
    if [ -n "$git_email" ]; then
        echo "Correo de Git configurado: $git_email"

        # Comprobar el dominio del correo
        if [[ "$git_email" == *@w001* ]]; then
            echo -e "\e[34mEste correo pertenece a w001\e[0m"  # Azul para correos que contienen 'w001'
        elif [[ "$git_email" == *@gmail.com ]]; then
            echo -e "\e[32mEste correo es de Gmail\e[0m"  # Verde para correos de Gmail
        else
            echo -e "\e[31mCorreo de dominio no reconocido\e[0m"  # Rojo para otros dominios
        fi
    else
        echo "Correo de Git no configurado"
    fi
else
    echo "No estás en un repositorio Git"
fi