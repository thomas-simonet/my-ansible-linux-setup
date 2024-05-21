## Todos

### dotfiles

- [ ] Remplacer le fichier "install-dotfiles.sh" par un "ansible.builtin.shell" ?
- [ ] Tuto sur l'utilisation de Fzf
- [ ] Tuto sur l'utilisation de Zoxide
- [ ] Autocompletion docker / docker compose
- [ ] Fix "cd:1: maximum nested function level reached; increase FUNCNEST?"

### Compose

- [ ] Faire en sorte que les containers dans le dossier compose se lance automatiquement après un reboot
- [ ] (Traefik) Mot de passe pour le dashboard

### Autres

- [ ] Installer les Guest Additions qu'une seule fois

## Installation

### Installation de Ansible (WSL)

```
sudo apt-get update
sudo apt-get install python3-pip git libffi-dev libssl-dev -y
pip install --user ansible pywinrm
```

#### Installer les roles :

```
ansible-galaxy role install -r ./provisioning/requirements.yml
```

## Installation locale

### Installation de Virtualbox (Windows)

https://www.virtualbox.org/wiki/Downloads

Copier le dossier d'installation, il sera nécessaire pour l'étape suivante.

## Installation de Vagrant

Depuis WSL

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vagrant
```

Editer le fichier "~/.bashrc"

```
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/mnt/c/Users/YOUR_USERNAME/"
export PATH="$PATH:/mnt/C:/Program Files/Oracle/VirtualBox"
```

=> Remplacer "YOUR_USERNAME" par votre nom d'utilisateur sous Windows

Editer le fichier "/etc/wsl.conf"

```
[automount]
enabled = true
root = /mnt/
options = "metadata,umask=77,fmask=11"
mountFsTab = false
```

## Connexion SSH

```
vagrant ssh-config > vagrant-ssh
ssh -F vagrant-ssh default
```

## Accéder aux sites sous docker

L'adresse IP par défaut de la VM est "192.168.56.18".

* Traefik est par défaut accessible à l'adresse https://traefik-192-168-56-18.traefik.me/dashboard/

* Portainer est par défaut accessible à l'adresse https://portainer-192-168-56-18.traefik.me

## Debug

#### Fix "WARNING: UNPROTECTED PRIVATE KEY FILE!"

https://www.schakko.de/2020/01/10/fixing-unprotected-key-file-when-using-ssh-or-ansible-inside-wsl/


## Ressources

https://thedatabaseme.de/2022/02/20/vagrant-up-running-vagrant-under-wsl2/