Day 83: Troubleshoot and Create Ansible Playbook

>Whatever we believe about ourselves and our ability comes true for us.
>
>– Susan L. Taylor

>The greatest glory in living, lies not in never falling, but in rising every time we fall.
>
>– Nelson Mandela

An Ansible playbook needs completion on the jump host, where a team member left off. Below are the details:

- The inventory file `/home/thor/ansible/inventory` requires adjustments. The playbook must run on `App Server 2` in Stratos DC. Update the inventory accordingly.**

- Create a playbook `/home/thor/ansible/playbook.yml`. Include a task to create an empty file `/tmp/file.txt` on `App Server 2`.

`Note:` Validation will run the playbook using the command `ansible-playbook -i inventory playbook.yml`. Ensure the playbook works without any additional arguments.

## Current Environment Analysis

**Existing Files in /home/thor/ansible/:**
```
inventory
```

**Current inventory Content:**
```ini
stapp02 ansible_host=172.238.16.204 ansible_user=steve ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

**Issues with Current Inventory:**
- Missing ansible_password for authentication
- Incorrect IP address (should be 172.16.238.11)
- Missing become settings for privilege escalation

## Solution

### Step 1: Fix the Inventory File
```bash
# Navigate to the ansible directory
cd /home/thor/ansible/

# Update the inventory file with correct configuration
cat > inventory << 'EOF'
[app_servers]
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Am3ric@ ansible_become_password=Am3ric@

[app_servers:vars]
ansible_become=yes
ansible_become_method=sudo
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF
```

### Step 2: Create the Playbook
```bash
# Create playbook.yml to create empty file on App Server 2
cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    - name: Create empty file /tmp/file.txt
      file:
        path: /tmp/file.txt
        state: touch
        mode: '0644'
EOF
```

### Step 3: Test and Validate
```bash
# Test connectivity
ansible -i inventory stapp02 -m ping

# Run the playbook
ansible-playbook -i inventory playbook.yml

# Verify file creation
ansible -i inventory stapp02 -m shell -a "ls -la /tmp/file.txt"
```

## Complete File Contents

**File: /home/thor/ansible/inventory**
```ini
[app_servers]
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Am3ric@ ansible_become_password=Am3ric@

[app_servers:vars]
ansible_become=yes
ansible_become_method=sudo
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

**File: /home/thor/ansible/playbook.yml**
```yaml
---
- hosts: all
  become: yes
  tasks:
    - name: Create empty file /tmp/file.txt
      file:
        path: /tmp/file.txt
        state: touch
        mode: '0644'
```

## Infrastructure Reference

**App Server 2 Details:**
- **Server**: stapp02
- **IP Address**: 172.16.238.11
- **Hostname**: stapp02.stratos.xfusioncorp.com
- **User**: steve
- **Password**: Am3ric@

## Expected Output

**Playbook execution:**
```bash
thor@jumphost ~/ansible$ ansible-playbook -i inventory playbook.yml

PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp02]

TASK [Create empty file /tmp/file.txt] *****************************************
changed: [stapp02]

PLAY RECAP *********************************************************************
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0



