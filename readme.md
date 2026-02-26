# My Ansible Linux Setup

This repository contains an opinionated Ansible playbook and a set of roles to provision a Docker-based homelab on Linux. It installs a reverse-proxy chain (Cloudflared + Traefik), a collection of containerized services (Grafana, Uptime Kuma, FreshRSS, Mealie, etc.), monitoring and update notifications (Diun + Apprise), and common system hardening and helpers.

## Disclaimer

This project is developed and tested from inside Windows Subsystem for Linux (WSL) and targets VPS instances provided by OVH. The playbooks and templates assume a Linux deployment host and networking behaviour typical of OVH VPS instances.

Other environments (different cloud providers, managed VPS products, or non-OVH setups) are not actively tested and may require additional adjustments.

Important: this setup uses Cloudflare Tunnel to expose services. You must own a domain managed by Cloudflare and enable Cloudflare's proxying for the tunnel to work with the default configuration.

## Supported applications

The repository provides roles for the following applications:

| Application | Description |
|---|---|
| [Apprise](https://github.com/caronc/apprise) | Notification gateway with many integrations and webhook support. |
| [Diun](https://github.com/crazy-max/diun) | Notifies when tracked Docker images are updated in registries. |
| [Backrest](./roles/backrest) | Backup/export utility for local volumes and configuration. |
| [Grafana](https://github.com/grafana/grafana) | Dashboards and visualization for metrics. |
| [Karakeep](https://github.com/karakeep-app/karakeep) | Self-hosted knowledge/bookmark manager with a web UI. |
| [Mealie](https://github.com/hay-kot/mealie) | Recipe manager and meal planner with a friendly UI. |
| [FreshRSS](https://github.com/FreshRSS/FreshRSS) | Lightweight self-hosted RSS reader. |
| [Uptime Kuma](https://github.com/louislam/uptime-kuma) | Uptime monitoring and status pages. |
| [Traefik](https://github.com/traefik/traefik) | Reverse proxy and load balancer for containerized services. |
| [Cloudflared](https://github.com/cloudflare/cloudflared) | Cloudflare Tunnel client used to expose local services securely. |

## Roadmap / TODO

- Replace manual Cloudflare Tunnel configuration with DockFlare to simplify tunnel management: https://github.com/ChrispyBacon-dev/DockFlare
- Consider replacing Diun with an image-update tool that provides a web UI for easier management

## AI integration

Tested to selfhost a small model (Qwen3-8b) using Ollama, but it was too slow. So i'm using OPENAI right now. Might switch later.


## Installation

1. Clone the repository:

```bash
git clone https://github.com/thomas-simonet/my-ansible-linux-setup.git .
```

2. Install Just (task runner): https://github.com/casey/just

3. Install UV (Python environment manager): https://github.com/astral-sh/uv

4. Bootstrap the development environment and install dependencies:

```bash
just setup    # installs dependencies and sets up pre-commit
```

Manual alternative:

```bash
uv sync
uv run ansible-galaxy install -r requirements.yml
uv run pre-commit install
```

## Prepare your first run (staging)

Before running the playbook you must create an inventory and populate host variables.

1. Copy the example staging inventory:

```bash
cp inventory/staging.example.yml inventory/staging.yml
```

2. Edit `inventory/staging.yml` and set the following fields for your host(s):

- `ansible_host`: public IP or hostname of your OVH VPS
- `ansible_become_password`: sudo password for the deployment user (if using password sudo)
- `ansible_password`: SSH password for the deployment user (only if you use password SSH auth)

Note: OVH instances commonly use `ubuntu` as the default user. OVH sends the initial password in the provisioning email.

3. Generate an SSH key pair (if you don't already have one):

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Then Copy the public key into `data/keys/`

4. Create host variables for staging:

```bash
cp host_vars/all.example.yml host_vars/staging/all.yml
```

Edit `host_vars/staging/all.yml` and update values such as `default_username`, `default_email`, `default_password`, `timezone`, `server_fqdn`, and `server_ip_address`.

5. Copy the example playbook if needed:

```bash
cp playbook.example.yml playbook.yml
```

6. Run the common-install tag to prepare the server:

```bash
just staging --tags install-common
```

## Authentication with SSH

Password authentication is disabled by the `common` role. Use SSH key-based authentication for all deployments.

Update `inventory/staging.yml` to include:

- `ansible_user`: the deployment user (match `default_username` in `host_vars/staging/all.yml`)
- `ansible_ssh_private_key_file`: path to the private key on the machine running Ansible

Test SSH using the project's SSH config:

```bash
ssh -F ./ssh.example staging
```

## Cloudflare Tunnel

This project uses Cloudflare Tunnel to expose services through Cloudflare Zero Trust. Basic steps:

### Create a tunnel

1. Log in to the Cloudflare dashboard and select your domain.
2. Open "Zero Trust" (Access) and navigate to "Tunnels".
3. Create a new tunnel and select the Cloudflared client; give it a name.
4. Copy the tunnel token and paste it into `host_vars/staging/all.yml` at `cloudflared_tunnel_token`.
5. Copy the Tunnel ID and paste it into `cloudflared_tunnel_id`.

### Published application routes

For each application add a published application route:

- `Subdomain`: application name (e.g. `traefik`)
- `Domain`: your domain
- `Type`: HTTPS
- `URL`: https://traefik:443

Enable "No TLS Verify" and "HTTP2 connection" in additional application settings.

### Policies and applications

Create an Access policy (Access → Policies) to allow the users you want. Then register each application (Access → Applications → Add an application) and attach the appropriate policy.

### Cloudflare certificate

1. Navigate to "Settings", then "Resources".
2. "Cloudflare certificates" -> Click on "Manage"
3. Click on "Create certificate"
4. Click on "Generate certificate"
5. Download the .pem
6. Copy the file to `data/certificates/tunnel_cert.pem`

### Cloudflare API Token

To generate your API Token follow [this link](https://go-acme.github.io/lego/dns/cloudflare/#api-tokens), then paste your token at `cloudflare_dns_api_token` in "host_vars/staging/all.yml"

## Notifications

This setup uses Apprise (and Discord webhooks) to centralize notifications. I send notifications to a private Discord server.

- Diun: sends notifications when tracked container images are updated.
- Uptime Kuma: sends alerts when monitored services become unavailable.
- Backrest: sends notifications about backup jobs and their status.

To receive messages in Discord create a webhook (Server Settings → Integrations → Webhooks → New Webhook), copy the webhook URL and paste it into `host_vars/staging/all.yml` at:

- `discord_webhook_backup` — Backrest backup notifications
- `discord_webhook_update` — Diun image update notifications
- `discord_webhook_down` — Uptime Kuma service-down alerts

Treat webhook URLs as secrets and avoid committing them to public repositories.

## Installing applications

Edit `playbook.yml` to enable the roles you want to install (uncomment role entries). Docker, Traefik and Cloudflared are required and should remain enabled.

### Environment variables

Edit `host_vars/staging/all.yml` and provide the required environment variables for each enabled application.

### Running the playbook

```bash
just staging --tags install-app
```

## Production

For production deployment, replicate the staging setup in `host_vars/production/` and `inventory/production.yml`, then run the playbook against that inventory. Review `host_vars` carefully for production-safe settings (secrets, permissions, backups).
