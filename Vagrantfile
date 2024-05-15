# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.hostname = "homelab"
  config.vm.network "private_network", ip: "192.168.56.18"

  config.vm.provider "virtualbox" do |vb|
    # Solve "Stderr: VBoxManage.exe: error: RawFile#0 failed to create the raw output file /dev/null (VERR_PATH_NOT_FOUND)"
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    vb.customize [ "modifyvm", :id, "--natdnshostresolver1", "on" ]
    vb.customize [ "modifyvm", :id, "--natdnsproxy1", "on" ]
    vb.customize [ "modifyvm", :id, "--name", "homelab" ]
    vb.linked_clone = true
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
    ansible.extra_vars = { is_vagrant: true }

    # Solve "Vagrant gathered an unknown Ansible version"
    ansible.compatibility_mode = "2.0"
  end

end
