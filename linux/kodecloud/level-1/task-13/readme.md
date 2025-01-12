In alignment with security compliance standards, the Nautilus project team has opted to impose restrictions on crontab access. Specifically, only designated users will be permitted to create or update cron jobs.

Configure `crontab` access on App Server 1 as follows: Allow crontab access to `ravi` user while denying access to the `rod` user.

## Solution
```bash
#ssh into tony app server 1
ssh tony@172.16.238.10 
# put password

sudo vi /etc/cron.allow

# add the user ravi
ravi

# since the cron.deny was absent you will just allow rod without adding into any file incase you have cron.deny add rod inside and very task

## check file permissions
sudo ls -l /etc/cron.allow /etc/cron.deny
sudo chmod 644 /etc/cron.allow /etc/cron.deny
sudo chown root:root /etc/cron.allow /etc/cron.deny

```