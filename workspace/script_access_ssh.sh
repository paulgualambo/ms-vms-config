#!/bin/bash
ssh-keygen

USER_T="paul"
HOST_APP="192.168.18.122"
HOST_INFRA="192.168.18.123"
HOST_DEPLOY="192.168.18.124"

#SANDBOX
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_rsa.pub paul@192.168.56.10
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_rsa.pub paul@192.168.56.12
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_rsa.pub paul@192.168.56.14

sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.10
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.12
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.14

#STUDY
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_rsa.pub paul@192.168.56.20
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_rsa.pub paul@192.168.56.22
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_rsa.pub paul@192.168.56.24

sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.20
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.22
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.24

#W001

sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.30
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.32
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.34

#W002
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.40
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.42
sshpass -p 'P@ul1984' ssh-copy-id -f -i ~/.ssh/id_ed25519.pub paul@192.168.56.44

