The Nautilus DevOps team is testing various Ansible modules on servers in Stratos DC. They're currently focusing on file creation on remote hosts using Ansible. Here are the details:


a. Create an inventory file ~/playbook/inventory on jump host and include all app servers.


b. Create a playbook ~/playbook/playbook.yml to create a blank file /usr/src/app.txt on all app servers.


c. Set the permissions of the /usr/src/app.txt file to 0755.


d. Ensure the user/group owner of the /usr/src/app.txt file is tony on app server 1, steve on app server 2 and banner on app server 3.


Note: Validation will execute the playbook using the command ansible-playbook -i inventory playbook.yml, so ensure the playbook functions correctly without any additional arguments.


##Solution:
#### Step 1: Create the Inventory File
#### Create the inventory file at `~/playbook/inventory` with the following content:
```inventory
[app_servers]
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Am3ric@
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_password=BigGr33n
```

### Step 2: Create the Playbook
### Create the playbook at `~/playbook/playbook.yml` with the following content:

```yml
---
- name: Create a blank file on all app servers
  hosts: app_servers
  gather_facts: false
  become: true

  tasks:
    - name: Create a blank file /usr/src/app.txt
      file:
        path: /usr/src/app.txt
        state: touch
        mode: '0755'
        owner: "{{ ansible_user }}"
        group: "{{ ansible_user }}"
```

### Explanation:

#### Inventory file:
 - The inventory defines the app servers and their respective SSH connection details.

#### Playbook tasks:
 - hosts: app_servers: Targets all app servers in the inventory.
 - become: true: Ensures elevated privileges to create the file under /usr/src/.
 - file module:
   - Creates the file `/usr/src/app.txt` if it doesn’t exist (state: touch).
   - Sets permissions `(mode: '0755')`.
   - Dynamically assigns ownership (owner and group) using the ansible_user variable 
     (matches the user defined in the inventory).


#### Step 3: Run the Playbook
 Execute the playbook to verify the solution:
```bash
ansible-playbook -i ~/playbook/inventory ~/playbook/playbook.yml
```

```bash
# Verification Steps

# Log in to each app server and check the file properties:
ssh tony@172.16.238.10
ls -l /usr/src/app.txt

# Expected output on each server:
# Permissions: -rwxr-xr-x
# Owner/Group: Matches the user (tony on stapp01, steve on stapp02, banner on stapp03).

# Ensure the file exists:
cat /usr/src/app.txt

# (It should be empty since it’s a blank file.)
```