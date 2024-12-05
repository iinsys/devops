The Nautilus DevOps team needs to copy data from the jump host to all application servers in Stratos DC using Ansible. Execute the task with the following details:

tasks:
a. Create an inventory file /home/thor/ansible/inventory on jump_host and add all application servers as managed nodes.

b. Create a playbook /home/thor/ansible/playbook.yml on the jump host to copy the /usr/src/dba/index.html file to all application servers, placing it at /opt/dba.

Note: Validation will run the playbook using the command ansible-playbook -i inventory playbook.yml. Ensure the playbook functions properly without any extra arguments.

```bash
ls /usr/src/dba/index.html
ansible --version
ansible -i /home/thor/ansible/inventory app_servers -m ping
ansible-playbook -i /home/thor/ansible/inventory /home/thor/ansible/playbook.yml


##check
ssh tony@<App_Server_1_IP>
ls /usr/src/dba/index.html

Verification Steps
Check the /opt/dba directory on each server:
ssh tony@<App_Server_1_IP>
ls -l /opt/dba/


Ensure the index.html file is present and readable
cat /opt/dba/index.html

```