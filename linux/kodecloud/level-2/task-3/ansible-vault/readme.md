Secure Alternative (Avoid Storing Passwords in inventory.ini)
Instead of storing passwords in the inventory file, use SSH key-based authentication or an Ansible vault to store credentials securely.

Using SSH Key Authentication:

Generate an SSH key on your control node:
```bash
ssh-keygen -t rsa -b 2048
```
Copy the key to the target server:
```bash
ssh-copy-id steve@172.16.238.11
```
Modify inventory.ini to remove passwords:

Using Ansible Vault for Password Security:
ansible-vault create secrets.yml

## run the playbook
ansible-playbook -i inventory.ini setup_devops_dir.yml --ask-vault-pass

