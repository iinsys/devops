Following a security audit, the xFusionCorp Industries security team has opted to enhance application and server security with SELinux. To initiate testing, the following requirements have been established for `App server 3` in the `Stratos Datacenter`:



- Install the required `SELinux` packages.

- Permanently disable SELinux for the time being; it will be re-enabled after necessary configuration changes.

- No need to reboot the server, as a scheduled maintenance reboot is already planned for tonight.

- Disregard the current status of SELinux via the command line; the final status after the reboot should be `disabled`.

## Solution
# Steps to Configure SELinux on App Server 3

## 1. Connect to App Server 3
Use SSH to log into the `stapp03` server:

```bash
ssh banner@stapp03.stratos.xfusioncorp.com
# Password: BigGr33n

# Install SELinux Packages
# Ensure the necessary SELinux packages are installed:
sudo yum install -y selinux-policy selinux-policy-targeted

# Permanently Disable SELinux
# To disable SELinux permanently without requiring an immediate reboot:

# Open the SELinux configuration file:
sudo vi /etc/selinux/config

# Modify the SELINUX parameter to disabled:
SELINUX=disabled
# Save the file and exit.

# Verify Configuration
# Ensure the change has been applied by checking the configuration file:
cat /etc/selinux/config

# Expected output should show:
SELINUX=disabled

# No Reboot Required Now
# The current SELinux status on the server may still show as enabled, but the change will take effect after the next reboot during the scheduled maintenance.

# To confirm the planned status:
grep SELINUX= /etc/selinux/config
```
**Completion Check**
- SELinux packages are installed.
- The configuration file reflects SELINUX=disabled.
- Reboot is not performed; status change will be verified after the scheduled maintenance reboot.