The `Nautilus` system admins team has prepared scripts to automate several day-to-day tasks. They want them to be deployed on all app servers in `Stratos DC` on a set schedule. Before that they need to test similar functionality with a sample cron job. Therefore, perform the steps below:


a. Install `cronie` package on all `Nautilus` app servers and start `crond` service.

b. Add a cron `*/5 * * * * echo hello > /tmp/cron_text` for `root` user.

## Solutions
```bash
## Dooing it manually
ssh tony@stapp01.stratos.xfusioncorp.com  # For stapp01
ssh steve@stapp02.stratos.xfusioncorp.com  # For stapp02
ssh banner@stapp03.stratos.xfusioncorp.com  # For stapp03

# Install and configure Cronie on each server:

# Run the following commands on each server:

# Install cronie:
sudo yum install -y cronie

# Start and enable the crond service:
sudo systemctl start crond
sudo systemctl enable crond

## verify status
systemctl status crond


# Add the cron job: Open the root crontab:
sudo crontab -e

# Add the following line to schedule the job:
*/5 * * * * echo hello > /tmp/cron_text

## Test the cron job: Wait for 5 minutes and check if the file /tmp/cron_text exists:
cat /tmp/cron_text

## you should see 
hello

## using ansible
sudo yum update -y
sudo yum install ansible -y

sudo yum install epel-release -y
sudo yum install sshpass -y

sudo vi /etc/ansible/ansible.cfg

[defaults]
inventory = hosts.ini
host_key_checking = False

export ANSIBLE_HOST_KEY_CHECKING=False


ssh-keyscan -H 172.16.238.10 >> ~/.ssh/known_hosts
ssh-keyscan -H 172.16.238.11 >> ~/.ssh/known_hosts
ssh-keyscan -H 172.16.238.12 >> ~/.ssh/known_hosts


ansible-playbook -i hosts deploy_cron.yml
OR RUN IN DEBUG MODE
ansible-playbook -i hosts.ini deploy_cron.yml -vvv


## verify ssh into one of the servers
crontab -l
cat /tmp/cron_text
watch -n 5 cat /tmp/cron_text

```




