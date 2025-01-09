A `Nautilus` developer has stored confidential data on the jump host within `Stratos DC`. To ensure security and compliance, this data must be transferred to one of the app servers. Given developers lack direct access to these servers, the system admin team has been enlisted for assistance.

Copy `/tmp/nautilus.txt.gpg` file from jump server to `App Server 1` placing it in the directory `/home/appdata`.
## Solution
```bash
#Being already on jumphost server Verify the File Exists: Confirm that the file /tmp/nautilus.txt.gpg exists on the jump
ls -l /tmp/nautilus.txt.gpg

## Copy the File to App Server 1: Use the scp command to transfer the file to App Server 1:
scp /tmp/nautilus.txt.gpg tony@stapp01.stratos.xfusioncorp.com:/home/appdata/

# Replace tony with the username for App Server 1 if it changes in the future.
# Password: Ir0nM@n

#Verify the File on App Server 1: Log in to App Server 1 to confirm the file transfer:
ssh tony@stapp01.stratos.xfusioncorp.com

#Check the /home/appdata directory:
ls -l /home/appdata/nautilus.txt.gpg

## optionally we can also set appropriate permissions
sudo chown tony:tony /home/appdata/nautilus.txt.gpg
sudo chmod 600 /home/appdata/nautilus.txt.gpg
```