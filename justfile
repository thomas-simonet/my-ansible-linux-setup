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

[group('vagrant')]
get-ssh-config:
    vagrant ssh-config > ssh