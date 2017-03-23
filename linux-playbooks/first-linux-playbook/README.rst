* Go to the Ansible playbook's placed folder. Then create certficates folder to generate and put your own user certificate.pub to this folder::

    $ mkdir certificates
    $ cp ~/.ssh/id_rsa.pub certificates/
    $ mkpasswd --method=SHA-512 -S saltpass
    Password: Write_pass_for_crypt
    $6$rumburak$VWBmX.2lG3EueFzONEZBVdr68xWO4mjjZQ/SuF.nuIrav11YNQpT6FEwMGZAA7dPhaDX/Y9PwhTDupSYEmktl0

* In the configuration file of **/etc/ansible/ansible.cfg** file edit the following line and save file::
  
    host_key_checking = False

* Create hosts inventory file with the following contents(``181-184`` is Ubuntu14.04 servers, ``10-20`` CentOS7 servers, ``12`` is CentOS6.7 server)::
  
    $ cat hosts
    [allservers]
    172.16.100.10
    172.16.100.12
    172.16.100.20
    172.16.100.181
    172.16.100.182
    172.16.100.183
    172.16.100.184

* This playbook doing the following things::

    1. Update cache and packages if server is Ubuntu or Debian based.
    2. Update all packages if server is CentOS6 or CentOS7 based.
    3. Add group sudo if server is CentOS6 or CentOS7 based.
    4. Add sudo group to the /etc/sudoers file if server is CentOS6 or CentOS7 based.
    5. Create new user with name jshahverdiev and password which we given before and add this user to the sudo group.
    6. Add generated public key to the user_homdedir/.ssh/authorized_keys file.
    7. Disable SSH password base authentication, disable root login and change SSH port to 30000. 
    8. At the end reboot the servers.

* Execute the following command to apply playbook to all servers::

    $ sudo ansible-playbook -k -i hosts bootstrap.yml
