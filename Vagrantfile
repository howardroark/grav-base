# -*- mode: ruby -*-
# vim: set ft=ruby ts=2 sw=2 et sts=2 :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "debian/contrib-jessie64"

  config.ssh.forward_agent = true

  config.vm.network "forwarded_port", guest: 80, host: 8000

  config.vm.synced_folder ".", "/project"

  config.vm.provision :shell,
    path: ".ops/vagrant/provision.sh",
    :keep_color => true

end
