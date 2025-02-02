#!/bin/bash

BASE_EXECUTION_PATH="/home/paul/Documents/projects/infra-tools-getstart/virtual-machine"
BASE_EXECUTION_PATH=${BASE_EXECUTION_PATH//\\//}

VMS_CONFIG_PATH="/home/paul/Documents/projects/infra-tools-getstart/workspace/paul-pc01/vms.json"
VMS_CONFIG_PATH=${VMS_CONFIG_PATH//\\//}

# BASE_EXECUTION_PATH
# VMS_CONFIG_PATH
ENVIRONMENT=$1
ACTION='up'

echo "$BASE_EXECUTION_PATH"
echo "$VMS_CONFIG_PATH"

$BASE_EXECUTION_PATH/lib/common.sh $BASE_EXECUTION_PATH $VMS_CONFIG_PATH $ENVIRONMENT $ACTION