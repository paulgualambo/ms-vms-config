#!/bin/bash

group=$1
workspace=$2

# Open Visual Studio Code with the remote workspace
if [ "$group" == "w001" ]; then
    /home/paul/Documents/projects/infra-tools-getstart/workspace/paul-pc01/mv_run.sh w001
    remote_workspace_path="vscode-remote://ssh-remote+W001-APP-192.168.56.30/home/paul/workspace/wxxx-common/w001/workspace/cashback-reward.code-workspace"
    code --file-uri "$remote_workspace_path"
fi

