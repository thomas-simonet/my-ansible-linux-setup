# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"
  # Solve " The host path of the shared folder is not supported from WSL. Host path of the shared folder must be located on a file system with DrvFs type"
  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.hostname = "homelab.local"
  config.vm.network "private_network", ip: "192.168.56.18"

  config.vm.provider "virtualbox" do |vb|
    # Solve "Stderr: VBoxManage.exe: error: RawFile#0 failed to create the raw output file /dev/null (VERR_PATH_NOT_FOUND)"
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    vb.customize [ "modifyvm", :id, "--name", "homelab" ]
    vb.linked_clone = true
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
    ansible.extra_vars = { is_vagrant: true }
    # Solve "Vagrant gathered an unknown Ansible version"
    ansible.compatibility_mode = "2.0"
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "provisioning/vagrant.yml"
    ansible.extra_vars = { is_vagrant: true }
    # Solve "Vagrant gathered an unknown Ansible version"
    ansible.compatibility_mode = "2.0"
  end

end
