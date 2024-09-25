#!/bin/bash
USERNAME=paul
# Variables
SOURCE_DIR="/home/$USERNAME/workspace"         # Carpeta en la máquina virtual
DEST_DIR="/backup"    # Carpeta en la máquina host (sincronizada)
LOG_FILE="backup_sync.log"
LOG_FILE_ERROR="backup_sync_error.log"
COUNT=1

# Comando rsync con incremento de COUNT
while true; do
  echo "Se ejecuto la sincronizacion #$COUNT" >> $LOG_FILE
  rsync -avzh --delete --exclude='node_modules' $SOURCE_DIR/ $DEST_DIR/ 2>> $LOG_FILE_ERROR
  COUNT=$((COUNT + 1))
  
  # Verificar si COUNT es igual a 4 y salir del bucle si es así
  if [ $COUNT -eq 5 ]; then
    echo "COUNT ha llegado a 5, saliendo del script." >> $LOG_FILE
    break
  fi
  
  sleep 10
done