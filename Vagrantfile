# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"
  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]

    # Restaure la connexion internet de la VM lorsque la machine HOST sort de veille
    vb.customize [ "modifyvm", :id, "--nicpromisc1", "allow-all" ]
    vb.customize [ "modifyvm", :id, "--nicpromisc1", "deny" ]
  end

  # Corrige la date de la VM
  config.vm.provision :shell, :inline => "sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime", run: "always"

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
  end

end
