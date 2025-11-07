# Ansible Docker Homelab Setup - AI Assistant Instructions

## Architecture Overview

This is an Ansible-based homelab infrastructure that deploys containerized services via Docker Compose. The architecture follows a **reverse proxy + tunneled access** pattern:
- **Traefik** acts as the reverse proxy with automatic SSL via Cloudflare DNS challenge
- **Cloudflared** provides secure tunnel access without exposing ports
- Services communicate via Docker networks: `cloudflared`, `notification`, `diun`
- All containers run under `/mnt/docker/` with standardized directory structures

## Project Structure Patterns

### Role Organization
- Each service follows the pattern: `roles/{service}/tasks/{main.yml,install.yml}` + `templates/compose.yml.j2`
- **Main playbook flow**: `common` (base system) → `docker` → `traefik` → applications → `reboot`
- **Critical roles**: `common` (system prep), `traefik` (reverse proxy), `cloudflared` (tunnel), `reboot` (post-deploy cleanup)

### Configuration Management
- **Environment separation**: `inventory/{staging,production}.yml` + `host_vars/{staging,production}/all.yml`
- **Variable hierarchy**: Global vars in `host_vars/*/all.yml`, service-specific vars prefixed by service name
- **Secrets**: Direct in `host_vars/` files (Discord webhooks, passwords, API tokens)

## Development Workflows

### Deploy Commands (via justfile)
```bash
just staging                    # Deploy to staging environment  
just production                # Deploy to production environment
just playbook -t install-app   # Deploy only application roles
```

### Development Commands
```bash
just setup                     # Complete development environment setup (uv + pre-commit)
just sync                      # Sync dependencies from pyproject.toml
just lint                      # Run ansible-lint (production profile)
just yaml-lint                 # Run yamllint  
just check                     # Run all linting checks
just pre-commit                # Run pre-commit hooks
```

### Service Deployment Pattern
1. **Directory creation**: `/mnt/docker/{service}/` owned by `default_username`
2. **Template rendering**: `compose.yml.j2` → `compose.yml` with Jinja2 variables
3. **Container deployment**: `community.docker.docker_compose_v2` with `recreate: always`

### Standard Service Template Structure
```yaml
# All services include:
- traefik.enable=true
- traefik.http.routers.{service}.rule=Host(`{{ service_fqdn }}`)
- traefik.http.routers.{service}.tls.certresolver=cloudflareResolver
- diun.enable=true  # Container update notifications
- networks: cloudflared (external)
```

## Key Conventions

### Variable Naming
- **Service images**: `{service}_{service}_docker_image` (e.g., `traefik_traefik_docker_image`)
- **FQDNs**: `{service}_fqdn` for each service's domain
- **Global vars**: `default_username`, `timezone`, `server_fqdn`, `cloudflare_dns_api_token`

### File Permissions
- **Config files**: `0644` (readable configs like `compose.yml`, `traefik.yml`)
- **Secrets**: `0600` (sensitive files like `acme.json`)
- **Directories**: `0755` owned by `default_username:default_username`

### Network Architecture
- **Port binding**: `127.0.0.1:{port}:{port}` (localhost only, Traefik routes traffic)
- **External networks**: Services join pre-created networks (`cloudflared`, `notification`, `diun`)
- **No direct exposure**: All services accessed via Traefik reverse proxy

## Integration Points

### Notification System
- **Apprise** handles all notifications (backup, updates, downtime)
- **Discord webhooks** configured in `host_vars/*/all.yml` as `discord_webhook_{type}`
- **Diun** monitors container updates and sends notifications via Apprise

### Monitoring Stack
- **Grafana** + **Prometheus/VictoriaMetrics** for metrics
- **Loki** for log aggregation
- **Uptime Kuma** for service monitoring

### Security & Access
- **SSH**: Custom config via `common` role (`sshd.conf.j2`)
- **UFW**: Firewall rules managed by `common` role  
- **Cloudflared**: Zero-trust tunnel access (no direct port exposure)

## Code Quality & Standards

### Modern Python Tooling (uv-based)
- **Package Manager**: `uv` for fast dependency management and virtual environments
- **Configuration**: All tools configured in `pyproject.toml` (Ansible Lint, YAML Lint, uv settings)
- **Dependency Groups**: `dev` (full development), `lint` (CI-only linting)
- **Pre-commit hooks**: Automatic linting on commit via `.pre-commit-config.yaml`

### Linting Configuration
- **Ansible Lint**: Production profile in `pyproject.toml` for strict best practices
- **YAML Lint**: 120-character line length with sensible defaults
- **CI/CD**: GitHub Actions with uv for fast, reliable builds

### Development Workflow
1. One-time setup: `just setup` (installs dependencies + pre-commit)
2. Daily development: `just check` (run all linting)
3. Auto-fix issues: `just lint-fix` 
4. Sync dependencies: `just sync` (when pyproject.toml changes)

When modifying this setup, always consider the **reverse proxy chain** (Cloudflared → Traefik → Service) and ensure **proper network membership** for service communication.