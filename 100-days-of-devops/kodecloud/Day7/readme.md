Day 7: Configure Password-less SSH from thor (Jump Host) to all App Servers

>There are times to stay put, and what you want will come to you, and there are times to go out into the world and find such a thing for yourself.
>
>– Lemony Snicket

The system admins team of xFusionCorp Industries has set up some scripts on the Jump Host that run on regular intervals and perform operations on all App Servers in the Stratos Datacenter.

To make these scripts work properly, we need to ensure that the thor user on Jump Host has password-less SSH access to all App Servers using their respective sudo users:

- `tony` for App Server 1  
- `steve` for App Server 2  
- `banner` for App Server 3

## Infrastructure Overview  

| Server     | Hostname                         | User   | Password   | Purpose                  |
|------------|----------------------------------|--------|------------|--------------------------|
| stapp01    | stapp01.stratos.xfusioncorp.com | tony   | Ir0nM@n    | Nautilus App 1           |
| stapp02    | stapp02.stratos.xfusioncorp.com | steve  | Am3ric@    | Nautilus App 2           |
| stapp03    | stapp03.stratos.xfusioncorp.com | banner | BigGr33n   | Nautilus App 3           |
| jump_host  | jump_host.stratos.xfusioncorp.com | thor | mjolnir123 | Jump Host Access         |

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# ========= [ 1. SSH into the Jump Host as thor ] =========
ssh thor@jump_host
# Password: mjolnir123

# ========= [ 2. Generate SSH Key on Jump Host (if not already exists) ] =========
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa

# ========= [ 3. Copy Public Key to App Server 1: stapp01 (User: tony) ] =========
sshpass -p 'Ir0nM@n' ssh-copy-id -o StrictHostKeyChecking=no tony@stapp01

# ========= [ 4. Test SSH to stapp01 ] =========
ssh tony@stapp01
exit

# ========= [ 5. Copy Public Key to App Server 2: stapp02 (User: steve) ] =========
sshpass -p 'Am3ric@' ssh-copy-id -o StrictHostKeyChecking=no steve@stapp02

# ========= [ 6. Test SSH to stapp02 ] =========
ssh steve@stapp02
exit

# ========= [ 7. Copy Public Key to App Server 3: stapp03 (User: banner) ] =========
sshpass -p 'BigGr33n' ssh-copy-id -o StrictHostKeyChecking=no banner@stapp03

# ========= [ 8. Test SSH to stapp03 ] =========
ssh banner@stapp03
exit
```

## Notes

This allows the `thor` user on Jump Host to SSH into each App Server using the respective sudo user. This is critical for automated scripts to perform tasks without needing interactive login.