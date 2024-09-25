#!/bin/bash

echo 'common.sh'

if [ -n "$1" ]; then
  CURRENT_DIR="$1"
  echo "CURRENT_DIR $1"
fi

if [ -n "$2" ]; then
  VMS_CONFIG="$2"
  echo "VMS_CONFIG $2"
fi

if [ -n "$3" ]; then
  ENVIRONMENT="$3"
  echo "ENVIRONMENT $3"
fi

if [ -n "$4" ]; then
  ACTION="$4"
  echo "ACTION $4"
fi

MOUNTAING="true"
PROVISION="true"

# Crear un objeto JSON con jq
vm_args=$(jq -n \
--arg current_dir "$CURRENT_DIR" \
--arg vms_config "$VMS_CONFIG" \
--arg environment "$ENVIRONMENT" \
--arg action "$ACTION" \
--arg mountaing "$MOUNTAING" \
--arg provision "$PROVISION" \
    '{
    current_dir: $current_dir
    ,vms_config: $vms_config
    ,environment: $environment
    ,action: $action
    ,provision: $provision
    ,mountaing: $mountaing
    }'
)

echo $ACTION

#Registrar el ssh id en el vagrant .ssh .aws

cp -R ~/.ssh $CURRENT_DIR/scripts_to_provision/
cp -R ~/.aws $CURRENT_DIR/scripts_to_provision/

RELOAD="false"
export RELOAD
source $CURRENT_DIR/lib/vagrant-process.sh "$vm_args"

# echo "Reload $RELOAD"
if [ "$RELOAD" == "true" ]; then
  source $CURRENT_DIR/lib/vagrant-process.sh "$vm_args"
fi

echo "Eliminando .ssh .aws en la carpeta vagrant"

#eliminando los archivos
rm -rf $CURRENT_DIR/scripts_to_provision/.ssh
rm -rf $CURRENT_DIR/scripts_to_provision/.aws
