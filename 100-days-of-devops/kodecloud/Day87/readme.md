Day 87: Ansible Install Package

>Success doesn't come from what you do occasionally. It comes from what you do consistently.
>
>– Marie Forleo

>Focus on the outcome not the obstacle.
>
>– Unknown

The Nautilus Application development team wanted to test some applications on app servers in `Stratos Datacenter`. They shared some pre-requisites with the DevOps team, and packages need to be installed on app servers. Since we are already using Ansible for automating such tasks, please perform this task using Ansible as per details mentioned below:



1. Create an inventory file `/home/thor/playbook/inventory` on jump host and add all app servers in it.


2. Create an Ansible playbook `/home/thor/playbook/playbook.yml` to `install wget` package on all  app servers using Ansible `yum module`.


Make sure user thor should be able to run the playbook on jump host.

`Note:` Validation will try to run playbook using command `ansible-playbook -i inventory playbook.yml` so please make sure playbook works this way, without passing any extra arguments.

## Solution
```bash
# Navigate to the playbook directory
cd /home/thor/playbook/

# Create inventory file with all app servers
cat > inventory << 'EOF'
[app_servers]
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n ansible_become_password=Ir0nM@n
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Am3ric@ ansible_become_password=Am3ric@
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_password=BigGr33n ansible_become_password=BigGr33n

[app_servers:vars]
ansible_become=yes
ansible_become_method=sudo
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF

# Create playbook to install wget using yum module
cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    - name: Install wget package using yum
      yum:
        name: wget
        state: present
EOF

# Test connectivity
ansible -i inventory all -m ping

# Run the playbook
ansible-playbook -i inventory playbook.yml

# Verify wget installation
ansible -i inventory all -m shell -a "which wget"

# Alternative verification - check if wget package is installed
ansible -i inventory all -m shell -a "rpm -q wget"

# Troubleshooting: in case installation fails on any server, re-run the playbook
ansible-playbook -i inventory playbook.yml
# Check which servers have wget installed again
ansible -i inventory all -m shell -a "which wget"
```