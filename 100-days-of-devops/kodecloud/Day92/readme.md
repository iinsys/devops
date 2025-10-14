Day 92: Managing Jinja2 Templates Using Ansible

>The most important thing to do in solving a problem is to begin.
>
>– Frank Tyger

One of the Nautilus DevOps team members is working on to develop a role for httpd installation and configuration. Work is almost completed, however there is a requirement to add a jinja2 template for index.html file. Additionally, the relevant task needs to be added inside the role. The inventory file ~/ansible/inventory is already present on jump host that can be used. Complete the task as per details mentioned below:


a. Update `~/ansible/playbook.yml` playbook to run the httpd role on `App Server 1`.


b. Create a `jinja2 template index.html.j2` under `/home/thor/ansible/role/httpd/templates/` directory and add a line `This file was created using Ansible on <respective server>` (for example `This file was created using Ansible on stapp01` in case of App Server 1). Also please make sure not to hard code the server name inside the template. Instead, use `inventory_hostname` variable to fetch the correct value.


c. Add a task inside `/home/thor/ansible/role/httpd/tasks/main.yml` to copy this template on `App Server 1` under `/var/www/html/index.html`. Also make sure that `/var/www/html/index.html` file's permissions are `0644`.


d. The `user/group` owner of `/var/www/html/index.html` file must be respective `sudo user` of the server (for example tony in case of stapp01).


`Note:` Validation will try to run the playbook using command `ansible-playbook -i inventory playbook.yml` so please make sure the playbook works this way without passing any extra arguments.

## Solution
```bash
# Navigate to the ansible directory
cd /home/thor/ansible/

# Check existing structure
ls -la
cat inventory
cat playbook.yml

# Check existing role structure
ls -la role/httpd/
ls -la role/httpd/tasks/
cat role/httpd/tasks/main.yml

# Update playbook.yml to target App Server 1 (stapp01)
cat > playbook.yml << 'EOF'
---
- hosts: stapp01
  become: yes
  become_user: root
  roles:
    - role/httpd
EOF

# Create templates directory if it doesn't exist
mkdir -p role/httpd/templates/

# Create jinja2 template index.html.j2 with inventory_hostname variable
cat > role/httpd/templates/index.html.j2 << 'EOF'
This file was created using Ansible on {{ inventory_hostname }}
EOF

# Update the main.yml tasks file to include the template task
cat > role/httpd/tasks/main.yml << 'EOF'
---
# Install httpd package
- name: Install httpd package
  package:
    name: httpd
    state: present

# Start and enable httpd service
- name: Start and enable httpd service
  service:
    name: httpd
    state: started
    enabled: yes

# Deploy index.html using jinja2 template
- name: Deploy index.html from jinja2 template
  template:
    src: index.html.j2
    dest: /var/www/html/index.html
    owner: "{{ ansible_user }}"
    group: "{{ ansible_user }}"
    mode: '0644'
EOF

# Test connectivity to App Server 1
ansible -i inventory stapp01 -m ping

# Run the playbook
ansible-playbook -i inventory playbook.yml

# Verify httpd service is running on App Server 1
ansible -i inventory stapp01 -m shell -a "systemctl status httpd --no-pager -l"

# Verify the content of index.html file
ansible -i inventory stapp01 -m shell -a "cat /var/www/html/index.html"

# Verify file ownership and permissions
ansible -i inventory stapp01 -m shell -a "ls -la /var/www/html/index.html"

# Test web server response
ansible -i inventory stapp01 -m shell -a "curl -s localhost"

# Verify the role structure
find role/ -type f -exec echo "=== {} ===" \; -exec cat {} \;
```
