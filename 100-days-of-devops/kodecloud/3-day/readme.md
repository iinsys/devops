Day 3: Secure Root SSH Access

>You are exactly where you need to be. You are not behind.

# 🚀 DevOps Journey with KodeCloud – Day 3  
## ✅ Task: Disable Direct SSH Root Login on All App Servers

Following a security audit, the xFusionCorp security team has enforced a new protocol: **root should not be allowed to log in via SSH directly**. You are to **disable root SSH login** on all app servers in the **Stratos Datacenter**.

---

## 🔧 Affected Servers

| Server   | Hostname                     | User    |
|----------|------------------------------|---------|
| stapp01  | stapp01.stratos.xfusioncorp.com | tony    |
| stapp02  | stapp02.stratos.xfusioncorp.com | steve   |
| stapp03  | stapp03.stratos.xfusioncorp.com | banner  |

---

## 🛠️ Step-by-Step Commands for Each App Server

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

---

## ✅ Verification (Optional)

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

---

✅ **Result**: Root login via SSH has been disabled on **stapp01**, **stapp02**, and **stapp03** as required by the security policy.
