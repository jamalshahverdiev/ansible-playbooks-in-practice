#!/usr/bin/env bash

if [ "$(hostname)" = "anssrv1" ]
then
    sudo apt update && sudo apt dist-upgrade -y
    sudo apt-add-repository ppa:ansible/ansible -y
    sudo apt update && sudo apt install -y ansible
    sudo cat <<EOF >> /etc/hosts
10.1.2.42.101   webserver
10.1.2.42.102  dbserver
EOF
    echo "$1" > /vagrant/ansible/vault_pass.txt
    mkdir -p /home/vagrant/ansible
    cp -R /vagrant/ansible/* /home/vagrant/ansible
    chmod 644 /home/vagrant/ansible/{ansible.cfg,vault_pass.txt} 
else
    sudo yum clean all && sudo yum update -y
    sudo yum -y install epel-release && sudo yum -y install bash-completion net-tools bind-utils wget telnet vim expect gcc-c++ make jq unzip nfs-utils git
    sudo sed -i.bak -e 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    sudo systemctl stop firewalld && sudo systemctl disable firewalld
    sudo sed -i.bak -e 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    sudo sed -i.bak -e 's/keepcache=0/keepcache=1/' /etc/yum.conf
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm"
    sudo yum localinstall -y /home/vagrant/jdk-8u181-linux-x64.rpm
    sudo echo 'export JAVA_HOME=/usr/java/jdk1.8.0_181-amd64/jre' >> ~/.bashrc
    sudo echo 'export JAVA_HOME=/usr/java/jdk1.8.0_181-amd64/jre' >> /home/vagrant/.bashrc
fi
