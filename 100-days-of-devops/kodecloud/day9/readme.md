Day 9: Fix MariaDB Service Issue

>There are times to stay put, and what you want will come to you, and there are times to go out into the world and find such a thing for yourself.
>
>– Lemony Snicket

There is a critical issue going on with the Nautilus application in Stratos DC. The production support team identified that the application is unable to connect to the database. After digging into the issue, the team found that **MariaDB service is down** on the database server.

Look into the issue and **fix the same**.

## Infrastructure Info

| Server Name | IP Address     | Hostname                         | Username | Password   | Purpose                  |
|-------------|----------------|----------------------------------|----------|------------|--------------------------|
| jump_host   | Dynamic        | jump_host.stratos.xfusioncorp.com | thor     | mjolnir123 | Jump Server              |
| stdb01      | 172.16.239.10  | stdb01.stratos.xfusioncorp.com  | peter    | Sp!dy      | Nautilus DB Server (MariaDB) |

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1. Login to Jump Host
ssh thor@jump_host.stratos.xfusioncorp.com
# Password: mjolnir123

# 2. SSH into DB Server
ssh peter@stdb01
# Password: Sp!dy

# 3. Check MariaDB Status
sudo systemctl status mariadb
# Output: mariadb.service - MariaDB 10.x database server
#         Loaded: loaded (/usr/lib/systemd/system/mariadb.service)
#         Active: failed (Result: exit-code)

# 4. Inspect Journal Logs
sudo journalctl -xeu mariadb
# Found error: "Can't open directory '/var/lib/mysql/' (Errcode: 13 - Permission denied)"

# 5. Verify Ownership of /var/lib/mysql
ls -ld /var/lib/mysql
# Output: drwxr-xr-x. 27 root root ...
# Wrong owner: root

# 6. Fix Ownership
sudo chown -R mysql:mysql /var/lib/mysql

# 7. Restart MariaDB
sudo systemctl start mariadb

# 8. Enable Service on Boot
sudo systemctl enable mariadb

# 9. Confirm Status
sudo systemctl status mariadb
# Active: active (running)

# 10. Optional – Test MySQL Login
sudo mysql -u root
# Welcome to the MariaDB monitor!
```

## Result
- MariaDB service is now **running**.
- Nautilus application can **connect to the database** again.
- Root cause was **incorrect ownership** on `/var/lib/mysql` directory.