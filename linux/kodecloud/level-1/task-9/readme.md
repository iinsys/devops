In a bid to automate backup processes, the `xFusionCorp Industries` sysadmin team has developed a new bash script named `xfusioncorp.sh`. While the script has been distributed to all necessary servers, it lacks executable permissions on App Server 2 within the Stratos Datacenter.

Your task is to grant executable permissions to the `/tmp/xfusioncorp.sh` script on App Server 2. Additionally, ensure that all users have the capability to execute it.

## Solution
```bash
## ssh into the server 2
ssh steve@172.16.238.11

## verify the existence of the file
ls -l /tmp/xfusioncorp.sh


# grant executable permission to all users
sudo chmod a+rx /tmp/xfusioncorp.sh

# verify the permissions have been granted
ls -l /tmp/xfusioncorp.sh

## execute the script
/tmp/xfusioncorp.sh

## logout of the server
exit
```