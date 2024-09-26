#!/bin/bash
echo "function vagrant-process"
# Leer el argumento JSON
json_string=$1

# Usar jq para extraer valores del JSON
current_dir=$(echo "$json_string" | jq -r '.current_dir')
vms_config=$(echo "$json_string" | jq -r '.vms_config')
environment=$(echo "$json_string" | jq -r '.environment')
action=$(echo "$json_string" | jq -r '.action')
mountaing=$(echo "$json_string" | jq -r '.mountaing')
provision=$(echo "$json_string" | jq -r '.provision')

# Imprimir los valores para verificar
echo "Current Directory: $current_dir"
echo "vms_config: $vms_config"
echo "Environment: $environment"
echo "Action: $action"
echo "Mountaing: $mountaing"
echo "Provision: $provision"

echo "===========================================>>>>>"

cd $current_dir

# Leer el archivo JSON
json_string=$(cat $vms_config)

# Inicializar el array
vms=()

# Usar jq para extraer y procesar cada objeto en el array sandbox
while IFS= read -r line; do
  vms+=("$line")
done < <(echo "$json_string" | jq -c --arg environment "$environment" '.[$environment][] | select(.active == true) | 
    {
      hostname, 
      ip, 
      box_image, 
      username, 
      shared_folder_host,
      shared_folder_vm,
      script, 
      memory,
      provider,
      cpus,
      active
    }')

# Crear el JSON inicial usando jq
vms_config_json=$(jq -n \
  --argjson mountaing "$mountaing" \
  --argjson provision "$provision" \
  '{
    mountaing: $mountaing,
    provision: $provision,
    vms: []
  }')

for vm in "${vms[@]}"; do
  echo $vm
  # Extraer hostname e ip usando jq
  hostname=$(echo "$vm" | jq -r '.hostname')
  ip=$(echo "$vm" | jq -r '.ip')

  # Concatenar hostname e ip
  hostname_ip="${hostname}_${ip}"
  VM_EXISTS=$(VBoxManage list vms | grep "\"$hostname_ip\"")
  upfirsttime=true
  if [ "$VM_EXISTS" ]; then
    upfirsttime=false  
  fi

  vm_with_upfirsttime=$(echo "$vm" | jq --argjson upfirsttime "$upfirsttime" '. + {"upfirsttime": $upfirsttime}')
  vms_config_json=$(echo "$vms_config_json" | jq --argjson new_vm "$vm_with_upfirsttime" '.vms += [$new_vm]')
done

echo $vms_config_json

echo "Action Vagrant $action"
vms_config=$vms_config_json vagrant $action

# Recorrer el JSON y ejecutar el comando si upfirsttime es true
vms=$(echo "$vms_config_json" | jq -c '.vms[]')

RELOAD=$RELOAD
for vm in $vms; do
  hostname=$(echo "$vm" | jq -r '.hostname')
  _ip=$(echo "$vm" | jq -r '.ip')
  upfirsttime=$(echo "$vm" | jq -r '.upfirsttime')

  if [ "$upfirsttime" == "true" ]; then
    vm_name="${hostname}"
    echo "Ejecutando vagrant halt $vm_name"
    vms_config=$vms_config_json vagrant halt $vm_name
    RELOAD="true"

    #Eliminando datos de know_host
    echo "Eliminando datos de know_host ${_ip}"
    sed -i "/${_ip}/d" ~/.ssh/known_hosts
  fi
  
done

export RELOAD