# Configure ssh

## WINDOwS

git bash de windows
vim ~/.bash_profile

### Start ssh-agent if not already runningeval"


eval $(ssh-agent -s)


## Add your SSH private keys

ll ~/.ssh

ssh-add ~/.ssh/paul-laptop01-win-me-id-key_ed25519
ssh-add ~/.ssh/paul-laptop01-win-w001-id-key_ed25519
ssh-add ~/.ssh/paul-laptop01-win-w002-id-key_ed25519

ssh-add ~/.ssh/paul-laptop01-lfed-me-id-key_ed25519
ssh-add ~/.ssh/paul-laptop01-lfed-w001-id-key_ed25519
ssh-add ~/.ssh/paul-laptop01-lfed-w002-id-key_ed25519

ssh-add ~/.ssh/paul-laptop01-lpop-me-id-key_ed25519
ssh-add ~/.ssh/paul-laptop01-lpop-w001-id-key_ed25519
ssh-add ~/.ssh/paul-laptop01-lpop-w002-id-key_ed25519

ssh-add ~/.ssh/paul-pc01-lubu-me-id-key_ed25519
ssh-add ~/.ssh/paul-pc01-lubu-w001-id-key_ed25519
ssh-add ~/.ssh/paul-pc01-lubu-w002-id-key_ed25519

ssh-add ~/.ssh/paul-pc01-lfd-me-id-key_ed25519
ssh-add ~/.ssh/paul-pc01-lfd-w001-id-key_ed25519
ssh-add ~/.ssh/paul-pc01-lfd-w002-id-key_ed25519
