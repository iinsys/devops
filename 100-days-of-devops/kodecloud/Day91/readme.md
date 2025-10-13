Day 91: Ansible Lineinfile Module

>Be not in despair, the way is very difficult, like walking on the edge of a razor; yet despair not, arise, awake, and find the ideal, the goal.
>
>– Swami Vivekananda

The `Nautilus DevOps` team want to install and set up a simple `httpd` web server on all app servers in Stratos DC. They also want to deploy a sample web page using Ansible. Therefore, write the required playbook to complete this task as per details mentioned below.


We already have an inventory file under `/home/thor/ansible` directory on jump host. Write a playbook playbook.yml under `/home/thor/ansible` directory on jump host itself. Using the playbook perform below given tasks:


1. Install `httpd` web server on all app servers, and make sure its service is up and running.


2. Create a file `/var/www/html/index.html` with content:


> This is a Nautilus sample file, created using Ansible!


3. Using `lineinfile` Ansible module add some more content in `/var/www/html/index.html` file. Below is the content:

>Welcome to Nautilus Group!


- Also make sure this `new line` is added at the top of the file.


4. The `/var/www/html/index.html` file's `user` and group `owner` should be `apache` on all app servers.


The `/var/www/html/index.html` file's permissions should be `0644` on all app servers.


`Note:` Validation will try to run the playbook using command `ansible-playbook -i inventory playbook.yml` so please make sure the playbook works this way without passing any extra arguments.


## Solution
```bash
# Navigate to the ansible directory
cd /home/thor/ansible/

# Verify existing inventory file
cat inventory

# Create playbook.yml with httpd installation and lineinfile tasks
cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    # Install httpd web server
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
    
    # Create initial index.html file with base content
    - name: Create index.html with initial content
      copy:
        content: "This is a Nautilus sample file, created using Ansible!"
        dest: /var/www/html/index.html
        owner: apache
        group: apache
        mode: '0644'
    
    # Use lineinfile to add new content at the top of the file
    - name: Add welcome message at the top of index.html using lineinfile
      lineinfile:
        path: /var/www/html/index.html
        line: "Welcome to Nautilus Group!"
        insertbefore: BOF
        state: present
    
    # Ensure proper ownership and permissions are set
    - name: Set correct ownership and permissions for index.html
      file:
        path: /var/www/html/index.html
        owner: apache
        group: apache
        mode: '0644'
        state: file
EOF

# Test connectivity to all app servers
ansible -i inventory all -m ping

# Run the playbook
ansible-playbook -i inventory playbook.yml

# Verify httpd service is running on all servers
ansible -i inventory all -m shell -a "systemctl status httpd --no-pager -l"

# Verify the content of index.html file
ansible -i inventory all -m shell -a "cat /var/www/html/index.html"

# Verify file ownership and permissions
ansible -i inventory all -m shell -a "ls -la /var/www/html/index.html"

# Test web server response
ansible -i inventory all -m shell -a "curl -s localhost"
```