The `Nautilus` system admins team has rolled out a web UI application for their backup utility on the Nautilus backup server within the `Stratos Datacenter`. This application operates on port `6100`, and `firewalld` is active on the server. To meet operational needs, the following requirements have been identified:

Allow all incoming connections on port `6100/tcp`. Ensure the zone is set to `public`.

## Solution
```bash
# Access the backup server
ssh clint@172.16.238.16
# Password: H@wk3y3

##Check firewall status: verify the status of the firewall
sudo firewall-cmd --state

#. Allow Port 6100/tcp, Run the following command to allow incoming connections on port 6100 in the public zone:
sudo firewall-cmd --zone=public --add-port=6100/tcp --permanent

# Reload the Firewall, Reload the firewall configuration to apply the changes:
sudo firewall-cmd --reload

#Verify the Configuration, heck that port 6100/tcp is now allowed in the public zone:
sudo firewall-cmd --zone=public --list-ports
```

