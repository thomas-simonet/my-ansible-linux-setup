set dotenv-load
inventory := ".vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory"

[group('ansible')]
install-tags tags:
    ansible-playbook playbook.yml -i {{inventory}} --tags "{{tags}}" --extra-vars "is_vagrant=true"