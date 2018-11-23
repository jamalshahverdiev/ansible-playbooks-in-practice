# -*- mode: ruby -*-
# vi: set ft=ruby :

sshportPoint = "200"
print "Enter the ansible vault password: "
ansiblevault_pass = STDIN.gets.chomp
print "\n"
Vagrant.configure("2") do |tasksrv|
  require './vagrant-provision-reboot-plugin'
  (1..2).each do |i|
     tasksrv.vm.define "webdb#{i}" do |deploy|
       deploy.vm.box = "centos/7"
       deploy.vm.network :private_network, ip: "10.1.42.10#{i}"
       deploy.vm.hostname = "webdb#{i}"
       deploy.ssh.forward_agent = true
       deploy.vm.network :forwarded_port, guest: 22, host: "#{sshportPoint}1#{i}", id: "ssh"
       deploy.vm.provider :virtualbox do |v1|
         v1.customize ["modifyvm", :id, "--memory", 1024]
         v1.customize ["modifyvm", :id, "--name", "webdb#{i}"]
       end
       deploy.vm.provision "shell", path: "scripts/install.sh"
       deploy.vm.provision :unix_reboot
     end
  end
  tasksrv.vm.box = "ubuntu/xenial64"
  tasksrv.vm.define "anssrv1" do |anssrv|
    anssrv.vm.network :private_network, ip: "10.1.42.201"
    anssrv.vm.hostname = "anssrv1"
    anssrv.ssh.forward_agent = true
    anssrv.vm.network :forwarded_port, guest: 22, host: "#{sshportPoint}21", id: "ssh"
    anssrv.vm.provider :virtualbox do |v1|
      v1.customize ["modifyvm", :id, "--memory", 1024]
      v1.customize ["modifyvm", :id, "--name", "anssrv1"]
    end
    anssrv.vm.provision "shell", path: "scripts/install.sh", args: "#{ansiblevault_pass}"
    anssrv.vm.provision "shell", path: "scripts/callplaybooks.sh"
  end
end
