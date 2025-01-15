In the `Stratos Datacenter`, our `Storage server` is encountering performance degradation due to excessive processes held by the `nfsuser` user. To mitigate this issue, we need to enforce limitations on its maximum processes. Please set the maximum process limits as specified below:

- a. Set the soft limit to `1025`

- b. Set the hard limit to `2026`

# Solution
# Steps to Configure Process Limits

## 1. Connect to the Storage Server
Use SSH to log into the `ststor01` server:

```bash
ssh natasha@ststor01.stratos.xfusioncorp.com
#Password: Bl@kW

# Edit the Limits Configuration File, Open the /etc/security/limits.conf file for editing:
sudo vi /etc/security/limits.conf

# Add the following lines at the end of the file:
nfsuser  soft  nproc  1027
nfsuser  hard  nproc  2026
# save and exit

# Ensure PAM Configuration Includes pam_limits.so
# Verify that the PAM modules include pam_limits.so to enforce the limits. Check the following files:

# Open /etc/pam.d/password-auth:
sudo vi /etc/pam.d/password-auth

# Ensure the following line exists:
session     required      pam_limits.so

# Open /etc/pam.d/system-auth:
sudo vi /etc/pam.d/system-auth

# Ensure the same line exists:
session     required      pam_limits.so

# If these lines are missing, add them and save the files.

# Switch to the nfsuser User and Test
# To apply the changes, switch to the nfsuser account:
sudo su - nfsuser

# Test the soft limit:
ulimit -u

# Expected output:
1027

# Test the hard limit:
ulimit -Hu

# Expected output:
2026

# Verify the Limits
# To ensure the limits are enforced, try creating processes:
for i in {1..1027}; do sleep 1 & done

# This should succeed as it’s within the soft limit.

# Exceeding the soft limit:
for i in {1..1028}; do sleep 1 & done

# This should fail due to the soft limit.

# Similarly, test for the hard limit:
ulimit -u 2026

# Cleanup
# Kill any leftover processes to avoid resource consumption:
killall sleep

```
 **Completion Check**
- Ensure ulimit `-u` for nfsuser shows `1027`.
- Ensure ulimit `-Hu` for nfsuser shows `2026`.