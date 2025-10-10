Day 88: Ansible Blockinfile Module

>Real difficulties can be overcome; it is only the imaginary ones that are unconquerable.
>
>– Theodore N. Vail

The Nautilus DevOps team wants to install and set up a simple httpd web server on all app servers in Stratos DC. Additionally, they want to deploy a sample web page for now using Ansible only. Therefore, write the required playbook to complete this task. Find more details about the task below.


We already have an inventory file under `/home/thor/ansible directory` on jump host.
-  Create a playbook.yml under `/home/thor/ansible` directory on jump host itself.


- Using the playbook, install httpd web server on all app servers. Additionally, make sure its service should up and running.


- Using blockinfile Ansible module add some content in `/var/www/html/index.html` file. Below is the content:


>Welcome to XfusionCorp!

>This is  Nautilus sample file, created using Ansible!`

>Please do not modify this file manually!`


The `/var/www/html/index.html` file's user and group owner should be `apache`- on all app servers.


- The `/var/www/html/index.html `file's permissions should be `0755` on all app servers.


`Note:`


i. Validation will try to run the playbook using command `ansible-playbook -i inventory playbook.yml` so please make sure the playbook works this way without passing any extra arguments.


ii. Do not use any `custom` or `empty marker` for `blockinfile` module.

## Solution
```bash
# Navigate to the ansible directory
cd /home/thor/ansible/

# Verify existing inventory file
cat inventory

# Create playbook.yml with httpd installation and blockinfile content
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
    
    - name: Create index.html with blockinfile content
      blockinfile:
        path: /var/www/html/index.html
        create: yes
        owner: apache
        group: apache
        mode: '0755'
        block: |
          Welcome to XfusionCorp!
          This is  Nautilus sample file, created using Ansible!
          Please do not modify this file manually!
EOF

# Test connectivity to all app servers
ansible -i inventory all -m ping

# Run the playbook
ansible-playbook -i inventory playbook.yml

# Verify httpd service is running
ansible -i inventory all -m shell -a "systemctl status httpd"

# Verify index.html file content and permissions
ansible -i inventory all -m shell -a "ls -la /var/www/html/index.html"
ansible -i inventory all -m shell -a "cat /var/www/html/index.html"
```

**Verification Output:**
```bash
thor@jumphost ~/ansible$ ansible -i inventory all -m shell -a "ls -la /var/www/html/index.html"
stapp01 | CHANGED | rc=0 >>
-rwxr-xr-x 1 apache apache 158 Oct 10 12:00 /var/www/html/index.html

stapp02 | CHANGED | rc=0 >>
-rwxr-xr-x 1 apache apache 158 Oct 10 12:00 /var/www/html/index.html

stapp03 | CHANGED | rc=0 >>
-rwxr-xr-x 1 apache apache 158 Oct 10 12:00 /var/www/html/index.html
```