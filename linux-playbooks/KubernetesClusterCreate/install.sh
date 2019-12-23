#!/usr/bin/env bash
#===============================================================================
#
#          FILE:  install.sh
# 
#         USAGE:  ./install.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Jamal Shahverdiev (), jamal.shahverdiev@gmail.com
#       COMPANY:  Pronet LLC
#       VERSION:  1.0
#       CREATED:  12/04/2019 10:45:17 AM +04
#      REVISION:  ---
#===============================================================================

ansible-playbook prepareCerts.yml --extra-vars "@vars/global.yml"
ansible-playbook deploy-apilb.yml --extra-vars "@vars/global.yml"
ansible-playbook deploy-controllers.yml --extra-vars "@vars/global.yml"
ansible-playbook deploy-workers.yml --extra-vars "@vars/global.yml"
ansible-playbook configureAdmin.yml --extra-vars "@vars/global.yml"
