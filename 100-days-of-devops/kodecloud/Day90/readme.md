Day 90: Managing ACLs Using Ansible

>Do not wait to strike till the iron is hot; but make it hot by striking.

>There is no substitute for hard work.
>– Thomas Edison

There are some files that need to be created on all app servers in Stratos DC. The Nautilus DevOps team want these files to be owned by user root only however, they also want that the app specific user to have a set of permissions on these files. All tasks must be done using Ansible only, so they need to create a playbook. Below you can find more information about the task.



1. Create a playbook named `playbook.yml` under `/home/thor/ansible` directory on jump host, an inventory file is already present under `/home/thor/ansible` directory on Jump Server itself.


2. Create an empty file `blog.txt` under `/opt/itadmin/` directory on app server 1. Set some acl properties for this file. Using `acl` provide `read` `'(r)'` permissions to group tony (i.e entity is `tony` and `etype` is group).


3. Create an empty file `story.txt` under `/opt/itadmin/` directory on app server 2. Set some acl properties for this file. Using `acl` provide `read` + `write` `'(rw)'` permissions to user steve (i.e entity is `steve` and `etype` is user).


4. Create an empty file `media.txt` under `/opt/itadmin/` on app server 3. Set some acl properties for this file. Using `acl` provide `read` + `write` `'(rw)'` permissions to group banner (i.e entity is `banner` and `etype` is group).


`Note:` Validation will try to run the playbook using command `ansible-playbook -i inventory playbook.yml` so please make sure the playbook works this way, without passing any extra arguments.

## Solution
```bash
# Navigate to the ansible directory
cd /home/thor/ansible/

# Verify existing inventory file
cat inventory

# Create optimized playbook.yml with ACL tasks
cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    # Common task - Create directory on all servers
    - name: Create /opt/itadmin directory on all servers
      file:
        path: /opt/itadmin
        state: directory
        mode: '0755'
    
    # Server-specific file creation and ACL tasks
    - name: Create blog.txt on App Server 1 with ACL for tony group (read)
      block:
        - name: Create empty file blog.txt
          file:
            path: /opt/itadmin/blog.txt
            state: touch
            owner: root
            group: root
            mode: '0644'
        
        - name: Set ACL for tony group with read permissions
          acl:
            path: /opt/itadmin/blog.txt
            entity: tony
            etype: group
            permissions: r
            state: present
      when: inventory_hostname == 'stapp01'
    
    - name: Create story.txt on App Server 2 with ACL for steve user (read+write)
      block:
        - name: Create empty file story.txt
          file:
            path: /opt/itadmin/story.txt
            state: touch
            owner: root
            group: root
            mode: '0644'
        
        - name: Set ACL for steve user with read+write permissions
          acl:
            path: /opt/itadmin/story.txt
            entity: steve
            etype: user
            permissions: rw
            state: present
      when: inventory_hostname == 'stapp02'
    
    - name: Create media.txt on App Server 3 with ACL for banner group (read+write)
      block:
        - name: Create empty file media.txt
          file:
            path: /opt/itadmin/media.txt
            state: touch
            owner: root
            group: root
            mode: '0644'
        
        - name: Set ACL for banner group with read+write permissions
          acl:
            path: /opt/itadmin/media.txt
            entity: banner
            etype: group
            permissions: rw
            state: present
      when: inventory_hostname == 'stapp03'
EOF

# Test connectivity to all app servers
ansible -i inventory all -m ping

# Run the playbook
ansible-playbook -i inventory playbook.yml

# Verify ACL settings on each server
ansible -i inventory stapp01 -m shell -a "getfacl /opt/itadmin/blog.txt"
ansible -i inventory stapp02 -m shell -a "getfacl /opt/itadmin/story.txt"
ansible -i inventory stapp03 -m shell -a "getfacl /opt/itadmin/media.txt"

# Verify file ownership
ansible -i inventory all -m shell -a "ls -la /opt/itadmin/"
```


**ACL Verification Output:**
```bash
thor@jumphost ~/ansible$ ansible -i inventory stapp01 -m shell -a "getfacl /opt/itadmin/blog.txt"
stapp01 | CHANGED | rc=0 >>
# file: /opt/itadmin/blog.txt
# owner: root
# group: root
user::rw-
group::r--
group:tony:r--
mask::r--
other::r--

thor@jumphost ~/ansible$ ansible -i inventory stapp02 -m shell -a "getfacl /opt/itadmin/story.txt"
stapp02 | CHANGED | rc=0 >>
# file: /opt/itadmin/story.txt
# owner: root
# group: root
user::rw-
user:steve:rw-
group::r--
mask::rw-
other::r--

thor@jumphost ~/ansible$ ansible -i inventory stapp03 -m shell -a "getfacl /opt/itadmin/media.txt"
stapp03 | CHANGED | rc=0 >>
# file: /opt/itadmin/media.txt
# owner: root
# group: root
user::rw-
group::r--
group:banner:rw-
mask::rw-
other::r--
```