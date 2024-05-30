inventory := ".vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory"

[group('ansible')]
playbook *args:
    ansible-playbook {{ args }}

[group('ansible')]
production *args:
    ansible-playbook -i production.yml playbook.yml {{ args }}

[group('ansible')]
stagging *args:
    ansible-playbook -i {{inventory}} playbook.yml --extra-vars "is_vagrant=true" {{ args }}