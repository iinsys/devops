>You don’t learn to walk by following rules. You learn by doing, and falling over.
>
>– Richard Branson

# Day 12 – DevOps Daily Task
---------------------------------------
 Task: Troubleshoot Apache Not Reachable on Port 3001
 Date: Day 12
 Location: App Server 1 (stapp01.stratos.xfusioncorp.com)
 User: tony
 Password: Ir0nM@n

### Task Objective:
- Investigate why Apache is not reachable on port 3001 from the jump host.
- Use tools like `netstat`, `iptables`, and systemctl to diagnose and fix the issue.
- Ensure Apache is running, listening on 0.0.0.0:3001, and the firewall allows external access.
- Document all troubleshooting steps and commands used.

Our monitoring tool has reported an issue in Stratos Datacenter. One of our app servers has an issue, as its Apache service is not reachable on port 3001 (which is the Apache port). The service itself could be down, the firewall could be at fault, or something else could be causing the issue.



Use tools like telnet, netstat, etc. to find and fix the issue. Also make sure Apache is reachable from the jump host without compromising any security settings.

Once fixed, you can test the same using command curl http://stapp01:3001 command from jump host.

### Relevant Infrastructure Details

| Server    | Hostname                        | User  | Password   |
|-----------|----------------------------------|-------|------------|
| jump_host | jump_host.stratos.xfusioncorp.com| thor  | mjolnir123 |
| stapp01   | stapp01.stratos.xfusioncorp.com  | tony  | Ir0nM@n    |


> **Note:** These servers are YUM-based (CentOS/RHEL), so use `httpd` and YUM-specific commands where applicable.

#### How to SSH to the Right Servers

1. SSH to the jump host:
   ```sh
   ssh thor@jump_host.stratos.xfusioncorp.com
   # password: mjolnir123
   ```

2. From the jump host, SSH to stapp01:
   ```sh
   ssh tony@stapp01.stratos.xfusioncorp.com
   # password: Ir0nM@n
   ```


## Step-by-step Solution: Troubleshooting Apache Not Reachable on Port 3001

1. **SSH into the jump host and then the app server (e.g., stapp01):**
   ```sh
   ssh <jump_host>
   ssh <app_server>
   ```

2. **Check if Apache is running:**
   ```sh
   sudo systemctl status httpd
   # or for Ubuntu/Debian:
   sudo systemctl status apache2
   ```

3. **If not running, start Apache:**
   ```sh
   sudo systemctl start httpd
   # or
   sudo systemctl start apache2
   ```

4. **Check if Apache is listening on port 3001:**
   ```sh
   sudo netstat -tulnp | grep 3001
   # or
   sudo ss -tulnp | grep 3001
   ```

5. **If not, configure Apache to listen on port 3001:**
   - Edit the config file (CentOS/RHEL: `/etc/httpd/conf/httpd.conf`, Ubuntu: `/etc/apache2/ports.conf`)
   - Add or update:
     ```
     Listen 3001
     ```

6. **Restart Apache to apply changes:**
   ```sh
   sudo systemctl restart httpd
   # or
   sudo systemctl restart apache2
   ```

---

## Additional Troubleshooting Steps That Worked

### 1. Port 3001 Already in Use (by sendmail)

If Apache fails to start with an error like:
```
(98)Address already in use: AH00072: make_sock: could not bind to address 0.0.0.0:3001
```
Check what is using port 3001:
```sh
sudo netstat -tulnp | grep 3001
# or
sudo lsof -i :3001  # (install lsof if needed)
```
If you see sendmail using the port, stop and disable it:
```sh
sudo systemctl stop sendmail
sudo systemctl disable sendmail
```
Then start Apache again:
```sh
sudo systemctl start httpd
```

### 2. Apache Only Listening on 127.0.0.1

If netstat shows Apache is only listening on 127.0.0.1:3001, edit `/etc/httpd/conf/httpd.conf`:
```
Listen 0.0.0.0:3001
```
Restart Apache:
```sh
sudo systemctl restart httpd
```

### 3. Firewall (iptables) Blocking Port 3001

If firewalld is not installed, check iptables:
```sh
sudo iptables -L -n
```
If you see a REJECT rule, allow port 3001:
```sh
sudo iptables -I INPUT -p tcp --dport 3001 -j ACCEPT
sudo service iptables save
sudo systemctl restart iptables
```
Verify:
```sh
sudo iptables -L -n
```

### 4. Test from the Jump Host

After all fixes, test connectivity:
```sh
curl http://stapp01:3001
```

If you see the Apache welcome page or your app, the issue is resolved.

7. **Check firewall rules and open port 3001 if needed:**
   - For firewalld:
     ```sh
     sudo firewall-cmd --permanent --add-port=3001/tcp
     sudo firewall-cmd --reload
     ```
   - For UFW:
     ```sh
     sudo ufw allow 3001/tcp
     ```

8. **Test from the jump host:**
   ```sh
   curl http://stapp01:3001
   ```

---
If you see the Apache welcome page or your app, the issue is resolved.
