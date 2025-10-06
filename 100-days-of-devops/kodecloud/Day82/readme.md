Day 82: Create Ansible Inventory for App Server Testing

>Keep your face always toward the sunshine, and shadows will fall behind you.
>
>– Walt Whitman

The Nautilus DevOps team is testing Ansible playbooks on various servers within their stack. They've placed some playbooks under /home/thor/playbook/ directory on the jump host and now intend to test them on app server 2 in Stratos DC. However, an inventory file needs creation for Ansible to connect to the respective app. Here are the requirements:

## Key Requirements Analysis

**a. Create an ini type Ansible inventory file `/home/thor/playbook/inventory` on jump host.**
- **File Location**: Must be exactly `/home/thor/playbook/inventory`
- **File Type**: INI format (not YAML)
- **Target Host**: Jump host (where you're working)

**b. Include App Server 2 in this inventory along with necessary variables for proper functionality.**
- **Target Server**: Specifically App Server 2 (stapp02)
- **Required Variables**: SSH connection details, user credentials, etc.
- **Functionality**: Must work with existing playbooks

**c. Ensure the inventory hostname corresponds to the server name as per the wiki, for example stapp01 for app server 1 in Stratos DC.**
- **Naming Convention**: App Server 2 = `stapp02`
- **Consistency**: Follow standard Stratos DC naming

**Validation Command**: `ansible-playbook -i inventory playbook.yml`
- **No Extra Arguments**: Inventory must be self-contained
- **Must Work**: All connection details included in inventory

## Current Environment Analysis

**Existing Files in /home/thor/playbook/:**
```
ansible.cfg  playbook.yml
```

**ansible.cfg Content:**
```ini
[defaults]
host_key_checking = False
```

**playbook.yml Content:**
```yaml
---
- hosts: all
  become: yes
  become_user: root
  tasks:
    - name: Install httpd package    
      yum: 
        name: httpd 
        state: installed
    
    - name: Start service httpd
      service:
        name: httpd
        state: started
```

## Solution

### Step 1: Create the Inventory File
```bash
# Navigate to the playbook directory (you're already there)
cd /home/thor/playbook/

# Create the inventory file for App Server 2
cat > inventory << 'EOF'
[app_servers]
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Am3ric@ ansible_become_password=Am3ric@

[app_servers:vars]
ansible_become=yes
ansible_become_method=sudo
ansible_python_interpreter=/usr/bin/python3
EOF
```

### Step 2: Verify the Inventory File
```bash
# Check the inventory file content
cat inventory

# Test connectivity to App Server 2
ansible -i inventory stapp02 -m ping

# List all hosts in inventory
ansible -i inventory --list-hosts all
```

### Step 3: Test the Playbook
```bash
# Run the existing playbook against App Server 2
ansible-playbook -i inventory playbook.yml

# Verify httpd installation and service status
ansible -i inventory stapp02 -m shell -a "systemctl status httpd"
```

## Success Verification

**Expected Output for httpd status check:**
```bash
thor@jumphost ~/playbook$ ansible -i inventory stapp02 -m shell -a "systemctl status httpd"
stapp02 | CHANGED | rc=0 >>
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; preset: disabled)
     Active: active (running) since Mon 2025-10-06 23:00:42 UTC; 12s ago
       Docs: man:httpd.service(8)
   Main PID: 3154 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 177 (limit: 411140)
     Memory: 15.2M
     CGroup: /docker/507aed97e053cd70b4a36e27f2db36b26e27012dfcafc14ea36f1b9ceb9e2548/system.slice/httpd.service
             ├─3154 /usr/sbin/httpd -DFOREGROUND
             ├─3163 /usr/sbin/httpd -DFOREGROUND
             ├─3164 /usr/sbin/httpd -DFOREGROUND
             ├─3165 /usr/sbin/httpd -DFOREGROUND
             └─3166 /usr/sbin/httpd -DFOREGROUND

Oct 06 23:00:42 stapp02.stratos.xfusioncorp.com httpd[3154]: Server configured, listening on: port 80
Oct 06 23:00:42 stapp02.stratos.xfusioncorp.com systemd[1]: Started The Apache HTTP Server.
```

**Key Success Indicators:**
- **Return Code**: `rc=0` (success)
- **Service Status**: `Active: active (running)`
- **Listening Port**: `listening on: port 80`
- **Process Running**: Multiple httpd processes visible in CGroup

## Complete Inventory File Content

**File: `/home/thor/playbook/inventory`**
```ini
[app_servers]
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Am3ric@ ansible_become_password=Am3ric@

[app_servers:vars]
ansible_become=yes
ansible_become_method=sudo
ansible_python_interpreter=/usr/bin/python3
```

## Key Configuration Points

1. **Exact File Path**: `/home/thor/playbook/inventory` (no extensions)
2. **Hostname**: Must be `stapp02` (matches server name)
3. **All Variables**: Include ansible_host, ansible_user, ansible_password, ansible_become_password
4. **Python Interpreter**: Specify python3 to avoid compatibility issues
5. **Become Settings**: Enable sudo access for administrative tasks
6. **Host Key Checking**: Already disabled in ansible.cfg

## Expected Playbook Execution

The playbook will:
1. Connect to stapp02 (App Server 2)
2. Install httpd package using yum
3. Start httpd service
4. Use sudo privileges (become: yes, become_user: root)

## Troubleshooting

**Issue**: Permission denied when running playbook
**Solution**: Ensure `ansible_become_password=Am3ric@` is set correctly

**Issue**: Host unreachable
**Solution**: Verify IP address (172.16.238.11) and network connectivity

**Issue**: Python interpreter errors
**Solution**: `ansible_python_interpreter=/usr/bin/python3` is included in inventory



