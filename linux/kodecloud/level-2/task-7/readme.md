As per new application requirements shared by the `Nautilus` project development team, serveral new packages need to be installed on all app servers in `Stratos Datacenter`. Most of them are completed except for `net-tools`.

Therefore, install the `net-tools` package on all `app-servers`.

## Solution
```bash
##manual
ssh tony@172.16.238.10  # App Server 1
ssh steve@172.16.238.11  # App Server 2
ssh banner@172.16.238.12  # App Server 3

## install net-tools
sudo yum install -y net-tools   # For CentOS/RHEL
sudo apt-get install -y net-tools  # For Debian/Ubuntu 

## verify installation
ifconfig

## cleanup if there is need
rpm -q net-tools   # For CentOS/RHEL
dpkg -l | grep net-tools  # For Debian/Ubuntu



sudo yum update -y
sudo yum install ansible -y

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini install_net_tools.yml

ssh steve@172.16.238.11
sudo yum install -y net-tools  # Use 'apt' for Debian-based systems

ssh banner@172.16.238.12
sudo yum install -y net-tools


ansible-playbook -i hosts.ini install_net_tools.yml


```