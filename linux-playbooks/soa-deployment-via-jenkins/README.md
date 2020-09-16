#### Execute **deploy-smb.yml** file with external variables **prod** and **frontend**:
```bash
$ ansible-playbook deploy-smb.yml --extra-vars "env=prod variable_host=frontend"
```

#### Deploy ProTask or SMB with External variable **envname** to choose deploy environment from **hosts** file (ProTask or SMB):
```bash
$ ansible-playbook deploy-smb.yml --extra-vars "envname=protasks" --limit protasks[0]
$ ansible-playbook deploy-smb.yml --extra-vars "envname=backends" --limit backends[0]
```

#### Deploy only in the **backend1** server (But you you must defune **target** variable inside of the playbook file):
```bash
$ ansible-playbook deploy-smb.yml --extra-vars "target=backend1" --list-hosts
```

#### Limit playbook on the **backend1** server:
```bash
$ ansible-playbook deploy-smb.yml --limit backends[0]
```

#### Execute playbook with vault password from console and from **vault_password.txt** file:
```bash
$ ansible-playbook deploy-smb.yml --limit backends[0] --ask-vault-pass
$ ansible-playbook deploy-smb.yml --limit backends[0] --vault-id vault_password.txt
```

#### Call tagged task with name **cloneOrPullNodeSources** from **deploy-smb.yml** file
```bash
$ ansible-playbook deploy-smb.yml --tags cloneOrPullNodeSources --limit backends[0] --ask-vault-pass
```
