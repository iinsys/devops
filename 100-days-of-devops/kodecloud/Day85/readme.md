Day 85: Create Files on App Servers using Ansible

>Be not in despair, the way is very difficult, like walking on the edge of a razor; yet despair not, arise, awake, and find the ideal, the goal.
>
>– Swami Vivekananda

The Nautilus DevOps team is testing various Ansible modules on servers in `Stratos DC`. They're currently focusing on file creation on remote hosts using Ansible. Here are the details:

**a. Create an inventory file `~/playbook/inventory` on jump host and include all app servers.**

**b. Create a playbook `~/playbook/playbook.yml` to create a blank file `/home/webdata.txt` on all app servers.**

**c. Set the permissions of the `/home/webdata.txt` file to `0655`.**

**d. Ensure the `user/group` owner of the `/home/webdata.txt` file is tony on app `server 1`, steve on app `server 2` and banner on app `server 3`.**

**Note: Validation will execute the playbook using the command `ansible-playbook -i inventory playbook.yml`, so ensure the playbook functions correctly without any additional arguments.**

## Solution

### Step 1: Create the Inventory File
```bash
# Navigate to playbook directory (create if doesn't exist)
mkdir -p ~/playbook
cd ~/playbook

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
```

### Step 2: Create the Playbook
```bash
# Create playbook to create webdata.txt with specific ownership per server
cat > playbook.yml << 'EOF'
---
- hosts: stapp01
  become: yes
  tasks:
    - name: Create /home/webdata.txt on App Server 1
      file:
        path: /home/webdata.txt
        state: touch
        mode: '0655'
        owner: tony
        group: tony

- hosts: stapp02
  become: yes
  tasks:
    - name: Create /home/webdata.txt on App Server 2
      file:
        path: /home/webdata.txt
        state: touch
        mode: '0655'
        owner: steve
        group: steve

- hosts: stapp03
  become: yes
  tasks:
    - name: Create /home/webdata.txt on App Server 3
      file:
        path: /home/webdata.txt
        state: touch
        mode: '0655'
        owner: banner
        group: banner
EOF
```

### Step 3: Validate the Setup
```bash
# Test connectivity to all app servers
ansible -i inventory all -m ping

# Run the playbook
ansible-playbook -i inventory playbook.yml

# Verify file creation and permissions on all servers
ansible -i inventory all -m shell -a "ls -la /home/webdata.txt"
```

## Expected Validation Output

**Successful playbook execution:**
```bash
thor@jumphost ~/playbook$ ansible-playbook -i inventory playbook.yml

PLAY [stapp01] *****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp01]

TASK [Create /home/webdata.txt on App Server 1] *******************************
changed: [stapp01]

PLAY [stapp02] *****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp02]

TASK [Create /home/webdata.txt on App Server 2] *******************************
changed: [stapp02]

PLAY [stapp03] *****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp03]

TASK [Create /home/webdata.txt on App Server 3] *******************************
changed: [stapp03]

PLAY RECAP *********************************************************************
stapp01                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

**File verification output:**
```bash
thor@jumphost ~/playbook$ ansible -i inventory all -m shell -a "ls -la /home/webdata.txt"
stapp01 | CHANGED | rc=0 >>
-rw-r-xr-x 1 tony tony 0 Oct  7 12:00 /home/webdata.txt

stapp02 | CHANGED | rc=0 >>
-rw-r-xr-x 1 steve steve 0 Oct  7 12:00 /home/webdata.txt

stapp03 | CHANGED | rc=0 >>
-rw-r-xr-x 1 banner banner 0 Oct  7 12:00 /home/webdata.txt



