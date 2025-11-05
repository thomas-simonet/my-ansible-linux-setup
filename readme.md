## Applications

* Apprise (Push Notifications.) - [repo](https://github.com/caronc/apprise)
* Diun (Receive notifications when an image is updated on a Docker registry.) - [repo](https://github.com/crazy-max/diun)
* Freshrss (A free, self-hostable news aggregator.) - [repo](https://github.com/FreshRSS/FreshRSS)
* Mealie (Delf hosted recipe manager and meal planner.) - [repo](https://github.com/mealie-recipes/mealie)
* Grafana (The open and composable observability and data visualization platform.) - [repo](https://github.com/grafana/grafana)
* Readeck (Simple web application that lets you save the precious readable content of web pages you like and want to keep forever.) - [repo](https://codeberg.org/readeck/readeck)
* Resticker (Run automatic restic backups via a Docker container.) - [repo](https://github.com/djmaze/resticker)
* Traefik (The Cloud Native Application Proxy) - [repo](https://github.com/traefik/traefik)

## Installation

### Version

```
Ansible 2.17+
Python 3.10+
```

### Installation de Ansible (WSL)

```
sudo apt-get update
sudo apt-get install python3-pip git libffi-dev libssl-dev -y
pip install --user ansible pywinrm
```

#### Upgrade de Ansible

```
# Upgrade Ansible
pip install --upgrade --user ansible
```

#### Installer les pre-requis :

```
ansible-galaxy role install -r ./provisioning/requirements.yml
```

### Installation de just

https://github.com/casey/just

```
# create ~/bin
mkdir -p ~/bin

# download and extract just to ~/bin/just
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | sh -s -- --to ~/bin

# add `~/bin` to the paths that your shell searches for executables
# this line should be added to your shells initialization file,
# e.g. `~/.bashrc` or `~/.zshrc`
export PATH="$PATH:$HOME/bin"

# just should now be executable
just --help
```

## Connexion SSH

```
ssh -F ./ssh HOSTNAME
```

## Apprise

Pour tester les notifcations depuis l'interface web de Apprise, visiter l'admin à l'adresse apprise.YOURDOMAIN.XX et renseigner la configuration suivante :
```
backup=DISCORD_WEBHOOK_BACKUP
update=DISCORD_WEBHOOK_UPDATE
down=DISCORD_WEBHOOK_DOWN
```
Où DISCORD_WEBHOOK_BACKUP, DISCORD_WEBHOOK_UPDATE et DISCORD_WEBHOOK_DOWN correspondent aux adresses des webhooks discord. Ceux ci sont déjà renseignés
dans le fichier /host_wars/YOUR_ENV/all.yml