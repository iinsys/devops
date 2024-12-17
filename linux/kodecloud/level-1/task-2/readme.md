The system admin team at xFusionCorp Industries has streamlined access management by implementing group-based access control. Here's what you need to do:

a. Create a group named nautilus_admin_users across all App servers within the Stratos Datacenter.

b. Add the user jarod into the nautilus_admin_users group on all App servers. If the user doesn't exist, create it as well.

Check the documentation [kodecloud documentation](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus#infrastructure-details)
## Solution tasks was too stressful so i used ansible to make it simple
```bash

# The error sudo: apt: command not found suggests that the system does not use the apt package manager.
# This is common on non-Debian-based distributions (like RHEL, CentOS, or Fedora).
# If you are on a Red Hat-based system, you can use the yum or dnf package manager to install Ansible.

# Steps for Installing Ansible on Red Hat-Based Systems:

# Update System Packages:
sudo yum update -y

# Install EPEL Repository:
sudo yum install epel-release -y

# Install Ansible:
sudo yum install ansible -y

# Verify Ansible Installation:
ansible --version

ansible-playbook -i inventory.ini group_management.yml

##verify
ansible -i inventory.ini app_servers -m shell -a "getent group nautilus_admin_users"
ansible -i inventory.ini app_servers -m shell -a "id jarod"


```