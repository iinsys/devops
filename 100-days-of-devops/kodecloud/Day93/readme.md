Day 93: Using Ansible Conditionals

>I hear and I forget. I see and I remember. I do and I understand.
>
>– Confucius

The Nautilus DevOps team had a discussion about, how they can train different team members to use Ansible for different automation tasks. There are numerous ways to perform a particular task using Ansible, but we want to utilize each aspect that Ansible offers. The team wants to utilise Ansible's conditionals to perform the following task:


An inventory file is already placed under  `/home/thor/ansible` directory on jump host, with all the Stratos DC app servers included.


Create a playbook `/home/thor/ansible/playbook.yml` and make sure to use Ansible's `when` conditionals statements to perform the below given tasks.


1. Copy `blog.txt` file present under `/usr/src/itadmin` directory on jump host to App Server 1 under `/opt/itadmin` directory. Its user and group owner must be user `tony` and its permissions must be `0644`.


2. Copy `story.txt` file present under `/usr/src/itadmin` directory on jump host to App Server 2 under `/opt/itadmin` directory. Its user and group owner must be user `steve` and its permissions must be `0644`.


3. Copy `media.txt` file present under `/usr/src/itadmin` directory on jump host to App Server 3 under `/opt/itadmin` directory. Its user and group owner must be user `banner` and its permissions must be `0644`.


`**NOTE:**` You can use `ansible_nodename` variable from gathered facts with when condition. Additionally, please make sure you are running the play for all hosts i.e use `- hosts: all`.


`**Note:**` Validation will try to run the playbook using command `ansible-playbook -i inventory playbook.yml`, so please make sure the playbook works this way without passing any extra arguments.

## Solution
```bash
# Navigate to the ansible directory
cd /home/thor/ansible/

# Verify existing inventory file
cat inventory

# Create playbook.yml using Ansible conditionals
cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    # Copy blog.txt to App Server 1
    - name: Copy blog.txt to stapp01
      copy:
        src: /usr/src/itadmin/blog.txt
        dest: /opt/itadmin/blog.txt
        owner: tony
        group: tony
        mode: '0644'
      when: inventory_hostname == 'stapp01'

    # Copy story.txt to App Server 2
    - name: Copy story.txt to stapp02
      copy:
        src: /usr/src/itadmin/story.txt
        dest: /opt/itadmin/story.txt
        owner: steve
        group: steve
        mode: '0644'
      when: inventory_hostname == 'stapp02'

    # Copy media.txt to App Server 3
    - name: Copy media.txt to stapp03
      copy:
        src: /usr/src/itadmin/media.txt
        dest: /opt/itadmin/media.txt
        owner: banner
        group: banner
        mode: '0644'
      when: inventory_hostname == 'stapp03'
EOF

# Test connectivity to all app servers
ansible -i inventory all -m ping

# Run the playbook
ansible-playbook -i inventory playbook.yml

# Verify files and permissions on each server
ansible -i inventory stapp01 -m shell -a "ls -la /opt/itadmin/blog.txt"
ansible -i inventory stapp02 -m shell -a "ls -la /opt/itadmin/story.txt"
ansible -i inventory stapp03 -m shell -a "ls -la /opt/itadmin/media.txt"

# Verify file content
ansible -i inventory stapp01 -m shell -a "cat /opt/itadmin/blog.txt"
ansible -i inventory stapp02 -m shell -a "cat /opt/itadmin/story.txt"
ansible -i inventory stapp03 -m shell -a "cat /opt/itadmin/media.txt"
```
