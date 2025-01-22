# Administrative Tasks
## Introduction
Administrative tasks are tasks managed by a system administrator. System administrators also known as sysadmins are information technology (IT) professionals who make sure an organisation's computer systems are functioning and meet the needs of the organisation. System administrators support, troubleshoot, and maintain computer servers and networks.
These tasks includes;
1. Manage user and group accounts and related system files,
1. Automate system administrative tasks by scheduling jobs,
1. Localisation and Internationalisation, and many more.
## Manage user and group accounts and related system files
### Managing User and Group Accounts 

Linux provides a powerful set of tools for managing user and group accounts, crucial for system security and resource allocation. 

User Accounts:

• Adding Users account:

  Use useradd to add a new users.

  ```sh 
  useradd username #creates a user with no home directory
  ``` 
  Some essential flags used when adding a new user
  -m creates a new user account with its home directory
  -d Create a new user account with a custom home directory
  -c Comment about the user can be including when creating the user
  -g to add user to a group
  -s to create account with a specific login shell
```sh
  useradd -m username 
  useradd -d /path/to/home username 
  useradd -c "Comment about the user" username 
  useradd -g groupname username 
  useradd -s /path/to/shell username 
  ```
  

• Managing Users:

  * passwd: Change a user's password.

   ```sh
   passwd username
   ``` 
   ```sh
   passwd -e username #immediately expires a user's password
   ```

  * usermod: Modify user attributes (comment, group, home directory).

    ```sh
    usermod -l new_username old_username #to change the username
    usermod -c "New comment" username #to modify comment
    usermod -g groupname username    
    usermod -d /path/to/home username
    ```
    

  * id: Display user and group information.
```sh
        id username
```
    

  * groups: List groups a user belongs to.

     ```sh
        groups username
    ```

  * userdel: Delete a user account.
```sh
        userdel username
 ```   

  * chage: Manage password aging (minimum age, maximum age, warning period).

 ```sh 
 chage -l username # Show password aging infomation  for a user
 chage -m 14 -M 90 -W 7 username # Set minimum age (14 days), maximum age (90 days), and warning period (7 days) 
 chage -E year-month-day username #set expiration date 
 ```   
• Filter the password and group databases:

  Use getent to retrieve information from system databases. For example, getent passwd username retrieves the password entry for a user. 
```sh
    getent passwd username
    getent group groupname 
 ``` 
  

Group Accounts:

• Creating Groups:

  Use groupadd to create a new group.

```sh
    groupadd groupname
``` 

• Managing Groups: 

  * groupmod: Modify group attributes (name, etc.).
```sh
        groupmod -n new_group_name groupname
```    

  * groupdel: Delete a group.
```sh
        groupdel groupname
```    

Related Files:

• **/etc/passwd:** Stores user account information. This file his 7 colons which contains the **Username, passward, UID, GID, Option comment field, Home directory of user, and User shell**.

• **/etc/shadow:** Stores encrypted user passwords (for security).This file has 9 field namely **Username, Encrypted password, Date of last password change, Minimum password age, Maximum password age, Password warning period, Password inactivity period, Account expiration date, Reserved field**.

• **/etc/group:** Stores group information. This file has 4 fields namely **Group name, Group password, GID, Member list**.

• /etc/gshadow: Stores encrypted group password. It has 4 field which include **Group Name, Encrypted password, Group administrators, Group members**

• **/etc/skel:** Template directory copied when creating new users (customizable).

• **/etc/login.defs:** Contains system-wide defaults for user account management, defining settings like password aging, UID/GID ranges, and security options.

Permissions and Ownership:

• chown: Change the ownership of a file or directory.

    chown username:groupname filename
  

• chgrp: Change the group ownership of a file or directory.

    chgrp groupname filename
  

• chmod: Change file permissions (read, write, execute).

    chmod 755 filename # Owner: read/write/execute, Group: read/execute, Others: read/execute
  

Security Best Practices:

• Strong passwords: Enforce complexity policies.
• Limited permissions: Grant only necessary permissions to users.
• Account review: Identify unused accounts and disable them.
• Password rotation: Require users to change passwords regularly.
• System updates: Patch vulnerabilities promptly.

### Commands that do similar task 
1. passwd and chage

|Passwd Command   |   chage command    |description|
|-----------------|--------------------|-----------|        
|   passwd -n              |  chage -m                  |minimum lifetime for passward|
|  passwd -x               |   chage -M                 |Set the maximum password lifetime for a user account|
|   passwd -w              |      chage -W              |Set the number of days of warning before the password expires 
|   passwd -i              |   chage -I                 |Set the number of days of inactivity after a password expires during which the user shouldupdate the password (otherwise the account will be disabled)|
|  passwd -S               | chage -l                   |show brief information about the password of the user account

2.passwd and usermod

|passwd  |usermod  |description
|--------|---------|----------|
| passwd -l                | usermod -L                   |lock a user
|passwd -u| usermod -U|unlocks a user
3. useradd and usermod 

|Options    |usermod |useradd       |
|-----------|--------|--------------| 
|-e        |  reset expiration date      |set expiration date              | 
| -s        | change login shell       |   set login shell           | 
|       -c       | modify comment       | create user with comment             |
|           -d   |  change user home directory      |set path to user home directory              | 
|    -g    |change user's primary group       | add user's primary group             |  
|    -G,-aG      |add user to secondary group or  add by overwriting        | add user to secondary group or  add by overwriting              |  

#### You can check the man page for more info on the commands ```useradd```, ```usermod```, ```groupadd```, ```groupmod```, ```passwd``` and ```chage```
