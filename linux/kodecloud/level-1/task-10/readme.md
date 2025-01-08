After conducting a security audit within the `Stratos DC`, the Nautilus security team discovered misconfigured permissions on critical files. To address this, corrective actions are being taken by the production support team. Specifically, the file named `/etc/hosts` on `Nautilus App 3` server requires adjustments to its Access Control Lists (ACLs) as follows:


- 1. The file's user owner and group owner should be set to `root`.

- 2. `Others` should possess read only permissions on the file.

- 3. User `anita` must not have any permissions on the file.

- 4. User `rod` should be granted `read only` permission on the file.

### Solution
```bash
# Connect to the Nautilus App 3 Server
ssh banner@172.16.238.12
# Password: BigGr33n

# Set User Owner and Group Owner to root
sudo chown root:root /etc/hosts

# Set Read-Only Permissions for Others
sudo chmod o=r /etc/hosts

# Remove Permissions for User anita
sudo setfacl -m u:anita:0 /etc/hosts

# Grant Read-Only Permission to User rod
sudo setfacl -m u:rod:r /etc/hosts

# Verify the ACL Settings
getfacl /etc/hosts

## expected output
getfacl: Removing leading '/' from absolute path names
# file: etc/hosts
# owner: root
# group: root
user::rw-          # File owner has read-write permissions
user:anita:---     # User anita has no permissions
user:rod:r--       # User rod has read-only permissions
group::r--         # Group has read-only permissions
mask::r--          # Effective rights mask: read-only for users and group
other::r--         # Others have read-only permissions
```
**Verification**

* **Ownership:** The owner and group are correctly set to `root`.
* **Permissions for Others:** Others have read-only permissions (`r--`).
* **Permissions for User anita:** User `anita` has no permissions (`---`).
* **Permissions for User rod:** User `rod` has read-only permissions (`r--`).

**Explanation of Each Command:**

* **Connect to the Server:**
    * Use SSH to connect to the Nautilus App 3 server using the provided credentials. 
    * `ssh banner@172.16.238.12`

* **Change Ownership:**
    * Change the owner and group of the `/etc/hosts` file to `root`.
    * `sudo chown root:root /etc/hosts`

* **Set Permissions:**
    * Set read-only permissions for others on the `/etc/hosts` file.
    * `sudo chmod o=r /etc/hosts`

* **Remove User Permissions:**
    * Use `setfacl` to remove all permissions for user `anita` on the `/etc/hosts` file.
    * `sudo setfacl -m u:anita:0 /etc/hosts`

* **Grant Permissions:**
    * Use `setfacl` to grant read-only access to user `rod`.
    * `sudo setfacl -m u:rod:r /etc/hosts`

* **Verify ACL Settings:**
    * Check the current Access Control List settings on the `/etc/hosts` file to ensure that the changes have been applied correctly.
    * `getfacl /etc/hosts`