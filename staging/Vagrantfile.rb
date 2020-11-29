# -*- mode: ruby -*-
# vi: set ft=ruby :

# The "2" in Vagrant.configure configures the configuration version 
# Please don't change it unless you know what you're doing.
Vagrant.configure("2") do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "geerlingguy/ubuntu2004"

  # SSH options.
  config.ssh.insert_key = 'false'
  config.ssh.forward_agent = true

  # VirtualBox.
  config.vm.define "virtualbox" do |virtualbox|
	# the virtual hostname
    virtualbox.vm.hostname = "vagrant.bradford-abbas.uk"
    virtualbox.vm.box = "geerlingguy/ubuntu2004"
    virtualbox.vm.network "private_network", :auto_network => true
    virtualbox.hostsupdater.aliases = ["staging.bradford-abbas.uk"]


    config.vm.provider :virtualbox do |v|
      v.gui = false
      v.memory = 1024
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end

    config.vm.provision "shell", inline: "echo Hello, World"
  end
end
