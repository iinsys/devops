Day 18: Configure LAMP server

>There is only one success - to be able to spend your life in your own way.
>
>– Christopher Morley

>Be not in despair, the way is very difficult, like walking on the edge of a razor; yet despair not, arise, awake, and find the ideal, the goal.
>
>– Swami Vivekananda

>Those who hoard gold have riches for a moment.
Those who hoard knowledge and skills have riches for a lifetime.
>
>– The Diary of a CEO

xFusionCorp Industries is planning to host a WordPress website on their infra in Stratos Datacenter. They have already done infrastructure configuration—for example, on the storage server they already have a shared directory `/vaw/www/html` that is mounted on each app host under `/var/www/html` directory. Please perform the following steps to accomplish the task:



a. Install httpd, php and its dependencies on all app hosts.


b. Apache should serve on port `6100` within the apps.


c. `Install/Configur`e` MariaDB server on DB Server.


d. Create a database named kodekloud_db1 and create a database user named `kodekloud_joy` identified as password `dCV3szSGNA`. Further make sure this newly created user is able to perform all operation on the database you created.


e. Finally you should be able to access the website on LBR link, by clicking on the App button on the top bar. You should see a message like App is able to connect to the database using user kodekloud_joy


## Solution
```bash
## on jump host
sudo yum install epel-release -y
sudo yum install ansible -y

ansible --version

echo -e "[defaults]\nhost_key_checking = False" | sudo tee /etc/ansible/ansible.cfg

## run play books
ansible-playbook wordpress-db.yml -vv
ansible-playbook wordpress-app.yml

```

**Access your WordPress site**
Go to the Load Balancer link and click App button:
https://80-port-kjdhgkq6ihwy4fib.labs.kodekloud.com/

You should see 
>App is able to connect to the database using user kodekloud_joy

**Note**:
If with time the playbooks get outdate please try to debug and follow same steps for similar task they might change just the password and port so you should also update that
