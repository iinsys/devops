Day 2: Create a Temporary User Account with an Expiry Date

>I can and I will. Watch me.
>
>– Carrie Green

As part of a temporary assignment to the Nautilus project, a developer named `siva` needs access to **App Server 2** in the **Stratos Datacenter**, but **only until 2024-03-28**.

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1. Connect to App Server 2 from the jump host
ssh steve@stapp02

# Accept the host key if prompted
# Type 'yes' and press Enter

# 2. Create a user named 'siva' with an account expiry date of 2024-03-28
# Format: YYYY-MM-DD
sudo useradd -e 2024-03-28 siva

# 3. Verify that the user was created and check the expiry date
sudo chage -l siva
```

## Expected Output from Verification Step

```
Last password change                                    : <some date>
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : Mar 28, 2024
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7
```

This confirms that:
- The user `siva` exists.
- The account will expire on **March 28, 2024**, after which login will be disabled automatically.
