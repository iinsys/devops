Day 1: Create a User with a Non-Interactive Shell on App Server 1

>A winner is a dreamer who never gives up.
>
>– Nelson Mandela

To accommodate the backup agent tool's specifications, the system admin team at xFusionCorp Industries requires the creation of a user named `siva` with a **non-interactive shell** on **App Server 1**.

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1. Connect to the App Server 1 (from the jump host)
ssh tony@stapp01

# Accept the host key if prompted
# Type 'yes' and press Enter

# 2. Check available shells (optional, for verification)
cat /etc/shells

# 3. Create the user 'siva' with a non-interactive shell
# Note: /sbin/nologin is used to prevent interactive logins
sudo useradd -s /sbin/nologin siva

# 4. Verify that the user was created with the correct shell
getent passwd siva
```

## Expected Output from Verification Step

The final command should return something similar to:

```
siva:x:1002:1002::/home/siva:/sbin/nologin
```

This confirms that:
- The user `siva` exists.
- The shell `/sbin/nologin` is correctly assigned.
- The user will not be able to log in interactively.
