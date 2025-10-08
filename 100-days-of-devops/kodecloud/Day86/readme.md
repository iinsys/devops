Day 86: Ansible Ping Module Usage

> The things always happens that you really believe in; and the belief >in a thing makes it happen.
>
> – Frank Lloyd Wrigh

The `Nautilus DevOps` team is planning to test several Ansible playbooks on different app servers in Stratos DC. Before that, some pre-requisites must be met. Essentially, the team needs to set up a password-less SSH connection between Ansible controller and Ansible managed nodes. One of the tickets is assigned to you; please complete the task as per details mentioned below:


a. Jump host is our Ansible controller, and we are going to run Ansible playbooks through thor user from jump host.


b. There is an inventory file `/home/thor/ansible/inventory` on jump host. Using that inventory file test `Ansible ping` from jump host to `App Server 3`, make sure ping works.

## Solution
```bash
# Navigate to the ansible directory
cd /home/thor/ansible/

# Update the inventory file with complete configuration
cat > inventory << 'EOF'
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_ssh_pass=Ir0nM@n
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_ssh_pass=Am3ric@
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_ssh_pass=BigGr33n

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_python_interpreter=/usr/bin/python3
EOF

# Test ping to App Server 3 (stapp03)
ansible -i inventory stapp03 -m ping

# Verify all hosts (optional)
ansible -i inventory all -m ping
```





