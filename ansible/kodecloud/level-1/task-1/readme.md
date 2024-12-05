Troubleshoot and create ansible playbook
Task:
An Ansible playbook needs completion on the jump host, where a team member left off. Below are the details:

1. The inventory file /home/thor/ansible/inventory requires adjustments. The playbook must run on App Server 3 in Stratos Dc. update the inventory  accordingly

2. Create a playbook /home/thor/ansible/playbook.yml. Include a task to create an empty file /tmp/file.txt on App Server 2

Note: Validation will run the playbookusing the command 
```bash
ansible-playbook -i inventory playbook.yml
```
Ensure the playbook works without additional arguments

check
```bash
ssh banner@stapp03
## past password
cd /tmp
ls -ltr
```