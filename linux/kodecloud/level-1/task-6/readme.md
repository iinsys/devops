Due to an accidental data mix-up, user data was unintentionally mingled on Nautilus `App Server 2` at the `/home/usersdata` location by the Nautilus production support team in Stratos DC. To rectify this, specific user data needs to be filtered and relocated. Here are the details:

Locate all files (excluding directories) owned by user `james` within the `/home/usersdata` directory on `App Server 2`. Copy these files while preserving the directory structure to the `/blog` directory.

### Solution

## Filtering and Copying Files with Preserved Directory Structure

This guide details how to filter and relocate files owned by the user `james` on App Server 2 (stapp02) while maintaining the original directory structure.

**Prerequisites:**

* Access credentials for the jump server (`jump_host.stratos.xfusioncorp.com`).

**Steps:**

1. **Access the Jump Server (ssh thor@jump_host.stratos.xfusioncorp.com):**

   ```bash
   ssh thor@jump_host.stratos.xfusioncorp.com
   Password: mjolnir123  # Replace with your actual password (not recommended to store passwords in plain text)
   ```
2. **Access App Server 2 (ssh steve@stapp02.stratos.xfusioncorp.com):**
```bash
ssh steve@stapp02.stratos.xfusioncorp.com
Password: Am3ric@  # Replace with your actual password (not recommended to store passwords in plain text)
```
3. **Locate and Copy Files:**
```bash
sudo find /home/usersdata -type f -user james -exec cp --parents {} /blog \;
```
**This command:**
- `find /home/usersdata`: Starts the search in the /home/usersdata directory.
- `-type f:` Filters for files only (excluding directories).
- `-user james:` Selects files owned by the user james.
- `-exec cp --parents {} /blog \;:` Executes the cp command for each found file:
- `--parents:` Preserves the directory structure within the destination (/blog).
- `{}:` Represents the current file found by find.
- `/blog`: The destination directory to copy the files to.

4. **Verify the Files:**
```bash
ls -lR /blog
exit
```


