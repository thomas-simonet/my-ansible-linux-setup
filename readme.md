## Applications

* Apprise (Push Notifications.) - [repo](https://github.com/caronc/apprise)
* Crowdsec (participative security solution offering crowdsourced protection against malicious IPs) - [repo](https://github.com/crowdsecurity/crowdsec)
* Diun (Receive notifications when an image is updated on a Docker registry.) - [repo](https://github.com/crazy-max/diun)
* Freshrss (A free, self-hostable news aggregator.) - [repo](https://github.com/FreshRSS/FreshRSS)
* Mealie (Delf hosted recipe manager and meal planner.) - [repo](https://github.com/mealie-recipes/mealie)
* Grafana (The open and composable observability and data visualization platform.) - [repo](https://github.com/grafana/grafana)
* Readeck (Simple web application that lets you save the precious readable content of web pages you like and want to keep forever.) - [repo](https://codeberg.org/readeck/readeck)
* Resticker (Run automatic restic backups via a Docker container.) - [repo](https://github.com/djmaze/resticker)
* Traefik (The Cloud Native Application Proxy) - [repo](https://github.com/traefik/traefik)
* Zipline (A ShareX/file upload server that is easy to use) - [repo](https://github.com/diced/zipline)

## Installation

### Version

```
Ansible 2.17.4
Python 3.10.12
```

### Installation de Ansible (WSL)

```
sudo apt-get update
sudo apt-get install python3-pip git libffi-dev libssl-dev -y
pip install --user ansible pywinrm

# Install ansible-lint for linting or ansible vscode extensions
pip install ansible-lint
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
```

## Debug

#### Fix "WARNING: UNPROTECTED PRIVATE KEY FILE!"

https://www.schakko.de/2020/01/10/fixing-unprotected-key-file-when-using-ssh-or-ansible-inside-wsl/