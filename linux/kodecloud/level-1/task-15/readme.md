In the daily standup, it was noted that the timezone settings across the `Nautilus Application Servers` in the `Stratos Datacenter` are inconsistent with the local datacenter's timezone, currently set to `America/Kralendijk`.

Synchronize the timezone settings to match the local datacenter's timezone (`America/Kralendijk`).

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
ansible-playbook -i inventory.ini set_timezone.yml
# or 
ansible-playbook -i inventory.ini set_timezone.yml --ask-become-pass


##verify 
ansible -i inventory.ini app_servers -m command -a "timedatectl"


## Manual initialization
#login into all the servers and on each folow the steps below
ssh tony@172.16.238.10
ssh steve@172.16.238.11
ssh banner@172.16.238.12

## check time zone settings
timedatectl

## set time zone 
sudo timedatectl set-timezone America/Kralendijk

# verify changes
timedatectl

## you should see
Local time: [Current date and time]
Time zone: America/Kralendijk (AST, -0400)
```
