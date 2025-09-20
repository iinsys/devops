Day 4: Make the Backup Script Executable by All Users

>Always bear in mind that your own resolution to success is more important than any other one thing.
>
>– Abraham Lincoln

The sysadmin team at xFusionCorp Industries has deployed a backup script named `xfusioncorp.sh` to `/tmp` on **App Server 3**. However, the script currently lacks executable permissions.

Your task is to:
- Make `/tmp/xfusioncorp.sh` executable.
- Ensure **all users** on the system can execute the script.

## Target Server

| Server   | Hostname                     | User    |
|----------|------------------------------|---------|
| stapp03  | stapp03.stratos.xfusioncorp.com | banner  |

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# ========= [ 1. Connect to the jump host ] =========
ssh thor@jump_host
# Password: mjolnir123

# ========= [ 2. Connect to App Server 3 ] =========
ssh banner@stapp03
# Password: BigGr33n

# ========= [ 3. Change permissions of the script ] =========
# Grant execute permission to all users (owner, group, others)
sudo chmod 755 /tmp/xfusioncorp.sh

# ========= [ 4. (Optional) Verify permissions ] =========
ls -l /tmp/xfusioncorp.sh

# Expected output:
# -rwxr-xr-x 1 root root <size> <date> /tmp/xfusioncorp.sh

# ========= [ 5. (Optional) Test if it runs ] =========
/tmp/xfusioncorp.sh
```

## Result

- The script is now executable by all users.
- Permission bits `r-x` (read + execute) for **group and others** are set.
- Script can now be run globally using `/tmp/xfusioncorp.sh`
