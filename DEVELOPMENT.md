# Development Setup

This document provides instructions for setting up the development environment and running linting tools using modern Python tooling with [uv](https://github.com/astral-sh/uv).

## Prerequisites

Install uv (Python package manager):
```bash
# On macOS and Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# On Windows
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

# Or via pip
pip install uv
```

## Quick Start

1. **One-time setup:**
   ```bash
   just setup
   ```

2. **Start development:**
   ```bash
   just check  # Run all linting checks
   ```

## Development Environment Setup

### Automatic Setup (Recommended)
```bash
just setup                    # Install dependencies and setup pre-commit hooks
```

### Manual Setup
```bash
# Install dependencies from pyproject.toml
uv sync

# Install Ansible collections
uv run ansible-galaxy install -r requirements.yml

# Set up pre-commit hooks
uv run pre-commit install
```

## Available Commands

### Using `just` (recommended):

```bash
# Development setup
just setup                   # Complete development environment setup
just sync                    # Sync dependencies from pyproject.toml

# Linting
just lint                    # Run ansible-lint
just lint-fix                # Run ansible-lint with auto-fix
just yaml-lint               # Run yamllint
just check                   # Run all linting checks

# Pre-commit & maintenance
just pre-commit              # Run pre-commit on all files  
just clean                   # Remove virtual environment and lock file

# Deployment
just staging                 # Deploy to staging
just production              # Deploy to production
```

### Direct uv commands:

```bash
# Environment management
uv sync                      # Install/sync dependencies
uv sync --group lint         # Install only linting dependencies
uv add --dev new-package     # Add new development dependency

# Linting
uv run ansible-lint          # Check for Ansible best practices
uv run ansible-lint --write  # Auto-fix issues where possible
uv run yamllint .            # Check YAML formatting

# Pre-commit
uv run pre-commit run --all-files   # Run all pre-commit hooks
uv run pre-commit run ansible-lint  # Run specific hook

# Syntax check
uv run ansible-playbook --syntax-check playbook.yml
```

## Project Structure

### Configuration Files
- `pyproject.toml` - Project metadata, dependencies, and tool configuration
- `.pre-commit-config.yaml` - Pre-commit hooks configuration  
- `uv.lock` - Locked dependency versions (auto-generated)

### Dependency Management
All dependencies are defined in `pyproject.toml`:
- **Base dependencies**: Ansible core
- **Development dependencies**: ansible-lint, yamllint, pre-commit
- **Lint-only dependencies**: For CI environments that only need linting

### Tool Configuration
All linting tools are configured in `pyproject.toml`:
- `[tool.ansible-lint]` - Ansible Lint configuration with production profile
- `[tool.yamllint]` - YAML Lint configuration with 120-character lines
- `[tool.uv]` - uv-specific settings and dependency groups

## CI/CD

The GitHub Actions workflow (`.github/workflows/lint.yml`) uses uv for:
- Fast dependency installation
- YAML linting with yamllint
- Ansible linting with ansible-lint (production profile)
- Syntax checking for playbooks

Runs automatically on pushes to `main`/`develop` and pull requests.

## Migration from pip

If migrating from pip-based setup:
1. Remove old `requirements*.txt` files
2. Run `just setup` to initialize uv environment
3. Update any local scripts to use `uv run` prefix