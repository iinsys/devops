With the installation of new tools on the app servers within the `Stratos Datacenter`, certain functionalities now necessitate graphical user interface (GUI) access.

Adjust the `default runlevel` on all App servers in `Stratos Datacenter` to enable GUI booting by default. It's imperative not to initiate a server reboot after completing this task.
## Solution
```bash
## using ansible
## install ansible
sudo yum update -y
sudo yum install ansible -y
ansible --version


##debug
ansible -i inventory.ini app_servers -m ping

## apply files
ansible-playbook -i inventory.ini enable_gui.yml

## verify configuration
ansible -i inventory.ini -m command -a "systemctl get-default" app_servers
ansible -i inventory.ini app_servers -m command -a "systemctl is-active graphical.target"


## doing it manually
## sssh into the servers
ssh tony@172.16.238.10   # For stapp01
ssh steve@172.16.238.11  # For stapp02
ssh banner@172.16.238.12 # For stapp03

# check corrent default target,Run the following command to check the current default runlevel:
systemctl get-default

# Set GUI as Default Runlevel, Change the default runlevel to graphical.target:
sudo systemctl set-default graphical.target

