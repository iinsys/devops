Within the Stratos DC, the backup server holds template XML files crucial for the Nautilus application. Before utilization, these files require valid data insertion. As part of routine maintenance, system admins at `xFusionCorp Industries` employ string and file manipulation commands.

Your task is to substitute all occurrences of the string `String` with `Maritime` within the XML file located at `/root/nautilus.xml` on the backup server.

## Solution
```bash
# Being already on the jumphost serve, ssh into the backup server
ssh clint@stbkp01.stratos.xfusioncorp.com
#H@wk3y3

## Backup the Original File: Before making any changes, create a backup of the file:
sudo cp /root/nautilus.xml /root/nautilus.xml.bak

# Edit the File Using sed: Use the sed command to replace String with Maritime:
sudo sed -i 's/String/Maritime/g' /root/nautilus.xml
```
- `-i`: Edits the file in place.
- `s/String/Maritime/g`: Substitutes all occurrences of String with Maritime.

```bash
#verification
sudo cat /root/nautilus.xml
```