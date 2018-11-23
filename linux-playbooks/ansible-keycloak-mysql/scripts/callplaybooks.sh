#!/usr/bin/env bash

cd /home/vagrant/ansible && ansible-playbook deploy-db.yml -i inventories/hosts --extra-vars "invt_name=db"
cd /home/vagrant/ansible && ansible-playbook deploy-web.yml -i inventories/hosts --extra-vars "invt_name=web"
