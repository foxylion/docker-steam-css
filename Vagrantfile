
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/wily64"
  config.ssh.shell = "bash"

  config.vm.define "dev" do |machine|
    machine.vm.provision "dev", type: "shell", path: ".vagrant/provision.sh"
    machine.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end
  end
end
