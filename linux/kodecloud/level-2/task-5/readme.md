The system admins team of `xFusionCorp Industries` has set up some scripts on jump host that run on regular intervals and perform operations on all app servers in `Stratos Datacenter`. To make these scripts work properly we need to make sure the `thor` user on jump host has password-less SSH access to all app servers through their respective sudo users (i.e `tony` for app server 1). Based on the requirements, perform the following:

Set up a password-less authentication from user `thor` on jump host to all app servers through their respective sudo users.

## solution
```bash
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa


#  Copy SSH Key to Each App Servervv
ssh-copy-id -i ~/.ssh/id_rsa.pub tony@172.16.238.10
#password:Ir0nM@n

ssh-copy-id -i ~/.ssh/id_rsa.pub steve@172.16.238.11
#Am3ric@

ssh-copy-id -i ~/.ssh/id_rsa.pub banner@172.16.238.12
#BigGr33n

#Test Password-less SSH Access
ssh tony@172.16.238.10
exit

ssh steve@172.16.238.11
exit

ssh banner@172.16.238.12
exit


#verify
ssh tony@172.16.238.10 "sudo whoami"
ssh steve@172.16.238.11 "sudo whoami"
ssh banner@172.16.238.12 "sudo whoami"

## output 
root
root
root

## Using Ansible
sudo yum update -y
sudo yum install ansible -y

###apply files
ansible-playbook -i hosts.ini setup-ssh.yml --ask-pass

ansible-playbook -i hosts.ini enable-sudo.yml


