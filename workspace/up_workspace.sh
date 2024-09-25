#!/bin/bash

HOST_VM=$1 #W001-APP-192.168.56.30
workspace=$2

HOST_VM_FOLDER=$(echo "$HOST_VM" | awk -F'-' '{print $1"-"$2}' | tr '[:upper:]' '[:lower:]')

#HOST="W001-APP-192.168.56.30"
remote_workspace_path="vscode-remote://ssh-remote+$HOST_VM/home/paul/workspace/wxxx-common/$HOST_VM_FOLDER/workspace/$workspace.code-workspace"
code --file-uri "$remote_workspace_path"
