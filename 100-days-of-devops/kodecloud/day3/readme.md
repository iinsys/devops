Day 3: Disable Direct SSH Root Login on All App Servers

>You are exactly where you need to be. You are not behind.

Following a security audit, the xFusionCorp security team has enforced a new protocol: **root should not be allowed to log in via SSH directly**. You are to **disable root SSH login** on all app servers in the **Stratos Datacenter**.

## Affected Servers

| Server   | Hostname                     | User    |
|----------|------------------------------|---------|
| stapp01  | stapp01.stratos.xfusioncorp.com | tony    |
| stapp02  | stapp02.stratos.xfusioncorp.com | steve   |
| stapp03  | stapp03.stratos.xfusioncorp.com | banner  |

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# ========= [ 1. Connect to the jump host ] =========
ssh thor@jump_host
# Password: mjolnir123

# ========= [ 2. Connect to stapp01 ] =========
ssh tony@stapp01
# Password: Ir0nM@n

# Edit the SSH configuration file
sudo vi /etc/ssh/sshd_config

# Find the line:
# PermitRootLogin yes
# And change it to:
PermitRootLogin no

# Save and exit (in vi: press ESC, type :wq, and press Enter)

# Restart the SSH service
sudo systemctl restart sshd

# Exit to jump host
exit

# ========= [ 3. Connect to stapp02 ] =========
ssh steve@stapp02
# Password: Am3ric@

sudo vi /etc/ssh/sshd_config
# Change PermitRootLogin to no
PermitRootLogin no
sudo systemctl restart sshd
exit

# ========= [ 4. Connect to stapp03 ] =========
ssh banner@stapp03
# Password: BigGr33n

sudo vi /etc/ssh/sshd_config
# Change PermitRootLogin to no
PermitRootLogin no
sudo systemctl restart sshd
exit
```

## Verification

On each app server, you can verify the setting with:

```bash
sudo grep PermitRootLogin /etc/ssh/sshd_config
```

Expected output:

```
PermitRootLogin no
```

And ensure the SSH daemon is running:

```bash
sudo systemctl status sshd
```
