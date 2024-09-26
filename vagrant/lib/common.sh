#!/bin/bash

echo 'common.sh'

if [ -n "$1" ]; then
  APP_BASE_PATH="$1"
  echo "APP_BASE_PATH $1"
fi

if [ -n "$2" ]; then
  MACHINE_OS_MAIN="$2"
  echo "MACHINE_OS_MAIN $2"
fi

if [ -n "$3" ]; then
  VIRTUALIZATION="$3"
  echo "VIRTUALIZATION $3"
fi

if [ -n "$4" ]; then
  GROUP="$4"
  echo "GROUP $4"
fi

if [ -n "$5" ]; then
  HOST="$5"
  echo "HOST $5"
fi

if [ -n "$6" ]; then
  ACTION="$6"
  echo "ACTION $6"
fi

# Crear un objeto JSON con jq
vm_args=$(jq -n \
--arg app_base_path "$APP_BASE_PATH" \
--arg vms_config "$APP_BASE_PATH\\workspace\\$MACHINE_OS_MAIN\\$VIRTUALIZATION-vms.json" \
--arg virtualization "$VIRTUALIZATION" \
--arg group "$GROUP" \
--arg host "$HOST" \
--arg action "$ACTION" \
    '{
    app_base_path: $app_base_path
    ,vms_config: $vms_config
    ,virtualization: $virtualization
    ,group: $group
    ,host: $host
    ,action: $action
    }'
)

echo $vm_args

#Registrar el ssh id en el vagrant .ssh .aws

cp -R ~/.ssh $APP_BASE_PATH/vagrant/resource_temp/
cp -R ~/.aws $APP_BASE_PATH/vagrant/resource_temp/

# RELOAD="false"
# export RELOAD
# source $CURRENT_DIR/lib/vagrant-process.sh "$vm_args"

# # echo "Reload $RELOAD"
# if [ "$RELOAD" == "true" ]; then
#   source $CURRENT_DIR/lib/vagrant-process.sh "$vm_args"
# fi

echo "Eliminando .ssh .aws en la carpeta vagrant"

#eliminando los archivos
rm -rf $CURRENT_DIR/resource_temp/*
