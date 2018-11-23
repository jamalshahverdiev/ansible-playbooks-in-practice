# Vagrant Ansible Task 

With these codes you will be able to install and configure fully automated KeyCloak and integrate with MySQL server.

## Getting Started

Below instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

This task was tested on Windows based host machine. However can be deployed on any platform that supports Vagrant and VirtualBox.

### Download and install 

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Git Bash](https://git-scm.com/downloads)

#### Installing

Open Git Bash console and create a new directory
```
$ mkdir vagrant_folder
$ cd vagrant_folder/
$ git clone https://github.com/salmanaghayev/ansible-task.git && cd ansible-task
```
Vagrant up command will install all required Operating Systems and execute playbooks.
```
$ vagrant up
```

## Running the manual test

If below link opens and requires username password and can be logged in with user: admin; pass: admin. It means everything is working

[http://10.1.42.102:9990](http://10.1.42.102:9990)

## Detailed description of how process will happen

First file to be executed by vagrant up is *vagrantfile*. It deploys two Centos machines (one for keycloak application and the other for MySQL database) and one Ubuntu machine (for Ansible) on VirtualBox. *Vagrantfile* also will run *scripts/install.sh* on all machines, which sets hostnames, IPs, installs Java, does updates as well as creates *vault_pass.txt* which later will encrypt  varies data. 
In addition Vagrantfile will run *scripts/callplaybooks.sh* on Centos machine which in our case will be Ansible server.  

*scripts/callplaybooks.sh* has two lines. One line will execute DB playbook with required arguments and the other will run WEB playbook.  

*tasks/deploy-db.yml* playbook will install MySQL on first Centos machine, copy *temps/my.cnf.j2* and overwrite */etc/my.cnf* config file which states mysql bind address, set new mysql root password, create database, db user and pass for keyclock server and add mysql service to the startup.  

*tasks/deploy-web.yml* playbook will download and install keycloak app  and mysql java connector. Playbook will also copy and rename */temps/module.xml.j2 to */app/keycloak/modules/system/layers/base/com/mysql/main/module.xml* and */temps/standalone.xml.j2* to */app/keycloak/standalone/configuration/standalone.xml*. Eventually test if the app works.  At the end if we see below it means Keycloak app is working.
```
TASK [Fail if Management Interface is not in the page content] *****************
skipping: [webserver]
```

