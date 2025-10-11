Day 89: Ansible Manage Services

>I can and I will. Watch me.
>
>– Carrie Green

Developers are looking for dependencies to be installed and run on Nautilus app servers in Stratos DC. They have shared some requirements with the DevOps team. Because we are now managing packages installation and services management using Ansible, some playbooks need to be created and tested. As per details mentioned below please complete the task:



a. On jump host create an Ansible playbook `/home/thor/ansible/playbook.yml` and configure it to install `httpd` on all app servers.


b. After installation make sure to start and enable `httpd` service on all `app servers`.


c. The inventory `/home/thor/ansible/inventory` is already there on `jump host`.


d. Make sure user `thor` should be able to run the playbook on `jump host`.


**`Note:`** Validation will try to run playbook using command `ansible-playbook -i inventory playbook.yml` so please make sure playbook works this way, without passing any extra arguments.

## Solution
```bash
# Navigate to the ansible directory
cd /home/thor/ansible/

# Verify existing inventory file
cat inventory

# Create playbook.yml to install and manage httpd service
cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    - name: Install httpd package
      yum:
        name: httpd
        state: present
    
    - name: Start and enable httpd service
      service:
        name: httpd
        state: started
        enabled: yes
EOF

# Test connectivity to all app servers
ansible -i inventory all -m ping

# Run the playbook
ansible-playbook -i inventory playbook.yml

# Verify httpd service status
ansible -i inventory all -m shell -a "systemctl status httpd"
ansible -i inventory all -m shell -a "systemctl is-enabled httpd"
```
**Service Verification:**
```bash
thor@jumphost ~/ansible$ ansible -i inventory all -m shell -a "systemctl is-enabled httpd"
stapp01 | CHANGED | rc=0 >>
enabled

stapp02 | CHANGED | rc=0 >>
enabled

stapp03 | CHANGED | rc=0 >>
enabled
```
**Troubleshooting Steps:**
```bash
# Check if httpd is running
ansible -i inventory all -m shell -a "systemctl status httpd"
# Re-run the playbook if service is not running
ansible-playbook -i inventory playbook.yml
# Verify again
ansible -i inventory all -m shell -a "systemctl status httpd"
```
