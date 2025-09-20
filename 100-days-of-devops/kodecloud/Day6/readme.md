Day 6: Install cronie and Set Up Sample Cron Job

>If you really look closely, most overnight successes took a long time.
>
>– Steve Jobs

The Nautilus team wants to verify automated task execution using cron before deploying production scripts. As part of this test:

- Install the **cronie** package on all 3 App Servers.
- Start and enable the **crond** service.
- Create a cron job for the **root user** that runs every 5 minutes and writes `hello` to `/tmp/cron_text`.

## Official Documentation Reference
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/configuring_basic_system_settings/assembly_configuring-and-maintaining-system-time_configuring-basic-system-settings#proc_installing-the-cronie-package_configuring-and-maintaining-system-time
- https://man7.org/linux/man-pages/man8/crond.8.html

## Target Servers

| Hostname | Username | Password  |
|----------|----------|-----------|
| stapp01  | tony     | Ir0nM@n   |
| stapp02  | steve    | Am3ric@  |
| stapp03  | banner   | BigGr33n  |

The passwords come from the [official documentations](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus#infrastructure-details) it might change in the feature so always make sure to look at the documentation first

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution

### Repeat these steps for each App Server

```bash
# ========= [ 1. SSH into the jump host ] =========
ssh thor@jump_host
# Password: mjolnir123

# ========= [ 2. SSH into the target app server (repeat for each one) ] =========
ssh tony@stapp01     # for stapp01
ssh steve@stapp02    # for stapp02
ssh banner@stapp03   # for stapp03

# ========= [ 3. Install cronie ] =========
sudo yum install -y cronie

# ========= [ 4. Start and enable crond service ] =========
sudo systemctl start crond
sudo systemctl enable crond

# ========= [ 5. Add cron job for root user ] =========
# This will run every 5 minutes and write 'hello' to /tmp/cron_text
echo "*/5 * * * * echo hello > /tmp/cron_text" | sudo tee -a /var/spool/cron/root

# ========= [ 6. Verify the cron entry ] =========
sudo crontab -l
# Output should show: */5 * * * * echo hello > /tmp/cron_text
```

## Result

- Cron is installed and running.  
- Every 5 minutes, `hello` will be written to `/tmp/cron_text` by the root user on all 3 app servers.

To validate later:
```bash
cat /tmp/cron_text
```