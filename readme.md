# My ansible linux setup

A concise Ansible-based playbook to provision and manage a Docker-powered homelab on Linux. The repository provides a set of Ansible roles and templates to deploy a reverse-proxy chain (Cloudflared + Traefik), containerized services (Grafana, Uptime Kuma, FreshRSS, Mealie, etc.), monitoring and update notifications (Diun + Apprise), and common system hardening and tooling.

## Disclaimer

This project is developed and tested to run inside Windows Subsystem for Linux (WSL) and targets a VPS provided by OVH.com. The playbooks and role templates assume a Linux deployment host and the networking/behaviour typically found on OVH VPS instances.

Important: Other platforms (native Linux distributions, cloud providers other than OVH, managed VPS offerings, or other hosting environments) are not tested and may require additional configuration or adaptation — they might not work out of the box. Use at your own risk.

Important: this setup relies on Cloudflare Tunnel for exposing services. You must have a domain name managed by Cloudflare and proxied through Cloudflare for the tunnel to work correctly.

## Applications

The following applications are supported by roles in this repository.

| Application | Description |
|---|---|
| [Apprise](https://github.com/caronc/apprise) | Notification gateway supporting many services and webhook integrations. |
| [Diun](https://github.com/crazy-max/diun) | Notifies when Docker images are updated in remote registries. |
| [Backrest](./roles/backrest) | Backup/export service for local volumes and configuration data. |
| [Grafana](https://github.com/grafana/grafana) | Time-series visualization and dashboarding platform for metrics. |
| [Karakeep](https://github.com/karakeep-app/karakeep) | A self-hostable bookmark-everything app (links, notes and images). |
| [Mealie](https://github.com/hay-kot/mealie) | Recipe manager and meal planner with a friendly web UI. |
| [FreshRSS](https://github.com/FreshRSS/FreshRSS) | Lightweight, self-hosted RSS aggregator and web-based reader. |
| [Uptime Kuma](https://github.com/louislam/uptime-kuma) | Self-hosted monitoring with uptime checks and status pages. |
| [Traefik](https://github.com/traefik/traefik) | Modern reverse proxy and load balancer for containerized workloads. |
| [Cloudflared](https://github.com/cloudflare/cloudflared) | Cloudflare Tunnel client to securely expose local services. |

## Todo

Planned improvements and ideas for this repository:

- Add an SMTP service ([SMTP2GO](https://www.smtp2go.com/)) to send email notifications and alerts: .
- Replace manual Cloudflare Tunnel configuration with DockFlare to automate tunnel/container management: [DockFlare](https://github.com/ChrispyBacon-dev/DockFlare).
- Add Ollama to self-host AI models for Karakeep and Mealie (automatic tagging and content tagging).
- (Maybe) Replace Diun with an alternative image update service that provides a Web UI for easier management.

## Installation

Follow these steps to get started:

1. Clone the repository:

```bash
git clone https://github.com/thomas-simonet/my-ansible-linux-setup.git .
```

2. Install Just (task runner): [Follow the instruction](https://github.com/casey/just?tab=readme-ov-file#pre-built-binaries)

3. Install UV (Python environment manager): [Follow the instruction](https://github.com/astral-sh/uv?tab=readme-ov-file#installation)

4. Run the following commands :

```bash
just setup                    # Install dependencies and setup pre-commit hooks
```

or (Manual)

```bash
# Install dependencies from pyproject.toml
uv sync

# Install Ansible collections
uv run ansible-galaxy install -r requirements.yml

# Set up pre-commit hooks
uv run pre-commit install
```

# Prepare your first run (Staging env)

Before running the playbook for the first time, create an inventory for your environment and populate SSH/sudo credentials.

1. Copy the example inventory for staging and name it `staging.yml`:

```bash
cp inventory/staging.example.yml inventory/staging.yml
```

2. Edit `inventory/staging.yml` and replace the following placeholders with your VPS details:

- `ansible_host` — set to the public IP of your OVH VPS.
- `ansible_become_password` — the sudo password for the deployment user.
- `ansible_password` — the SSH password for the deployment user.

Important: The default user for OVH VPS instances is `ubuntu`. The initial password is included in the provisioning email OVH sends after deploying the VPS.

Important: Password authentication is disabled after running the role `common`.

3. Generate an SSH Key Pair

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Then copy the public key in `data/keys`.

4. Copy the example host_vars `all.example.yml` and name it `all.yml`:

```bash
cp host_vars/all.example.yml host_vars/staging/all.yml
```

5. Edit `host_vars/staging/all.yml` and replace the following placeholders:

- `default_password` - the sudo password for the deployment user.
- `timezone` - Your desired timezone.
- `server_fqdn` - Your domain name.
- `server_ip_address` - set to the public IP of your OVH VPS.

6. Copy the example playbook `playbook.example.yml` and name it `playbook.yml`:

```bash
cp playbook.example.yml playbook.yml
```

7. You're ready to run your first playbook!

```bash
just staging --tags install-common
```
