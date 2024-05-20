# save the config to a file
vagrant ssh-config > vagrant-ssh

# run ssh with the file.
ssh -F vagrant-ssh default



# Fix "WARNING: UNPROTECTED PRIVATE KEY FILE!"

https://www.schakko.de/2020/01/10/fixing-unprotected-key-file-when-using-ssh-or-ansible-inside-wsl/


https://thedatabaseme.de/2022/02/20/vagrant-up-running-vagrant-under-wsl2/


## Installation de Ansible (WSL)

sudo apt-get update
sudo apt-get install python3-pip git libffi-dev libssl-dev -y
pip install --user ansible pywinrm


### Installer les roles :

ansible-galaxy role install -r ./provisioning/requirements.yml


## Installation de Virtualbox (Windows)

https://www.virtualbox.org/wiki/Downloads

Copier le dossier d'installation pour plus tard. Exemple : C:\Program Files\Oracle\VirtualBox


## Installation de Vagrant (WSL)

(Depuis WSL)

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vagrant


dans ~/.bashrc

export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/mnt/c/Users/YOUR_USERNAME/"
export PATH="$PATH:/mnt/C:/Program Files/Oracle/VirtualBox"


dans /etc/wsl.conf

[automount]
enabled = true
root = /mnt/
options = "metadata,umask=77,fmask=11"
mountFsTab = false



## Todo

### dotfiles

* Remplacer le fichier "install-dotfiles.sh" par un "ansible.builtin.shell" ?
* Tuto sur l'utilisation de Fzf
* Tuto sur l'utilisation de Zoxide
* Ajouter une tasks "Install packages" pour les packages spécifique à ce role
* Autocompletion docker / docker compose