# type: ignore

[group('ansible')]
playbook *args:
    ansible-playbook {{ args }}

[group('ansible')]
[group('production')]
production *args:
    ansible-playbook -i inventory/production.yml playbook.yml {{ args }}

[group('ansible')]
[group('staging')]
staging *args:
    ansible-playbook -i inventory/staging.yml playbook.yml {{ args }}

# Development and linting commands (uv-based)
[group('dev')]
setup:
    @echo "Setting up development environment with uv..."
    uv sync
    uv run pre-commit install

[group('dev')]
sync:
    uv sync

[group('dev')]
lint:
    uv run ansible-lint

[group('dev')]
lint-playbook:
    uv run ansible-lint playbook.yml roles/

[group('dev')]
yaml-lint:
    uv run yamllint .

[group('dev')]
check:
    yaml-lint lint .

[group('dev')]
pre-commit:
    uv run pre-commit run --all-files
