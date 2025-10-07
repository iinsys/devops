84: Copy Data to App Servers using Ansible

>The way to get started is to quit talking and begin doing.
>
>– Walt Disney

The Nautilus DevOps team needs to copy data from the `jump host` to all `application` servers in `Stratos DC` using Ansible. Execute the task with the following details:

**a. Create an inventory file `/home/thor/ansible/inventory` on jump_host and add all application servers as managed nodes.**

**b. Create a playbook `/home/thor/ansible/playbook.yml` on the jump host to copy the `/usr/src/data/index.html` file to all application servers, placing it at `/opt/data`.**

**Note: Validation will run the playbook using the command `ansible-playbook -i inventory playbook.yml`. Ensure the playbook functions properly without any extra arguments.**

## Solution

### Step 1: Create the Inventory File
```bash
# Navigate to ansible directory (create if doesn't exist)
mkdir -p /home/thor/ansible
cd /home/thor/ansible

# Create inventory file with all application servers
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
```

### Step 2: Create the Playbook
```bash
# Create playbook to copy index.html to all app servers
cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    - name: Create destination directory /opt/data
      file:
        path: /opt/data
        state: directory
        mode: '0755'
    
    - name: Copy index.html from jump host to app servers
      copy:
        src: /usr/src/data/index.html
        dest: /opt/data/index.html
        mode: '0644'
EOF
```

### Step 3: Validate the Setup
```bash
# Test connectivity to all app servers
ansible -i inventory all -m ping

# Run the playbook
ansible-playbook -i inventory playbook.yml

# Verify file was copied to all servers
ansible -i inventory all -m shell -a "ls -la /opt/data/index.html"
```

## Expected Validation Output

**Successful playbook execution:**
```bash
thor@jumphost ~/ansible$ ansible-playbook -i inventory playbook.yml

PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp01]
ok: [stapp02]
ok: [stapp03]

TASK [Create destination directory /opt/data] **********************************
changed: [stapp01]
changed: [stapp02]
changed: [stapp03]

TASK [Copy index.html from jump host to app servers] **************************
changed: [stapp01]
changed: [stapp02]
changed: [stapp03]

PLAY RECAP *********************************************************************
stapp01                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
stapp02                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
stapp03                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0




