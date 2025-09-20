Day 5: Install and Permanently Disable SELinux (App Server 1)

>Hard work beats talent when talent doesn't work hard.
>
>– Tim Notke

The xFusionCorp Industries security team is preparing to enhance security using **SELinux**. As part of this initiative, the following actions must be completed on **App Server 1**:

- Install the necessary SELinux packages.
- Permanently disable SELinux (will be re-enabled after planned maintenance).
- A reboot is already scheduled — no need to perform it now.
- The current runtime SELinux status can be ignored.

## Target Server

| Server   | Hostname                     | User  |
|----------|------------------------------|-------|
| stapp01  | stapp01.stratos.xfusioncorp.com | tony  |

## Official Red Hat Documentation References
- SELinux config: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/security_hardening/assembly_using-selinux-configuration-security-hardening
- SELinux package group: https://access.redhat.com/solutions/36278

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# ========= [ 1. Connect to the jump host ] =========
ssh thor@jump_host
# Password: mjolnir123

# ========= [ 2. SSH into App Server 1 ] =========
ssh tony@stapp01
# Password: Ir0nM@n

# ========= [ 3. Install SELinux packages ] =========
# These include policycoreutils, selinux-policy, libselinux-utils, etc.
# This ensures proper SELinux management tools are available
sudo yum install -y selinux-policy selinux-policy-targeted policycoreutils policycoreutils-python-utils libselinux-utils

# ========= [ 4. Permanently disable SELinux ] =========
# Open the SELinux config file
sudo vi /etc/selinux/config

# Change the following line:
# SELINUX=enforcing
# To:
SELINUX=disabled

# Save and exit (in vi: press ESC, type :wq, and press Enter)

# ========= [ 5. (Optional) Verify the config file edit ] =========
grep SELINUX= /etc/selinux/config

# Output should show:
# SELINUX=disabled

# ========= [ 6. DO NOT reboot ] =========
# Reboot is planned and will apply the change. No need to reboot now.
```

## Expected Outcome After Reboot

Once the server reboots, SELinux will be **permanently disabled**, as configured in `/etc/selinux/config`.

Even though the current runtime output of `sestatus` may show it as enabled, that can be ignored per instruction.