As per details shared by the development team, the new application release has some dependencies on the back end. There are some packages/services that need to be installed on all app servers under `Stratos Datacenter`. As per requirements please perform the following steps:


a. Install `postfix` package on all the application servers.

b. Once installed, make sure it is enabled to start during boot.

## Solution
```bash
## installl ansible
sudo yum update -y
sudo yum install ansible -y


## apply file
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini install_postfix.yml


## debug : if a server or one of the server gives an error then you can ssh into it and install postfix manually
##use this to fix the errors 
ansible-playbook -i hosts.ini fix_postfix.yml
sudo yum install -y postfix


## verification
ansible -i hosts.ini app_servers -m shell -a "systemctl status postfix"
