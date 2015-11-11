
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/wily64"
  config.ssh.shell = "bash"

  config.vm.network "public_network"
  config.vm.provision "dev", type: "shell", path: ".vagrant/provision.sh"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end
end
