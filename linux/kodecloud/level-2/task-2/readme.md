During the monthly compliance meeting, it was pointed out that several servers in the `Stratos DC` do not have a valid banner. The security team has provided serveral approved templates which should be applied to the servers to maintain compliance. These will be displayed to the user upon a successful login.

Update the `message of the day` on all application and db servers for Nautilus. Make use of the approved template located at `/home/thor/nautilus_banner` on jump host

## Solution

```bash
## Dooing it manually
## ssh into each stratoes server and do this
ssh tony@172.16.238.10
# Enter password: Ir0nM@n

# Transfer the MOTD template from the jump host to the target server:
scp /home/thor/nautilus_banner tony@172.16.238.10:/tmp/nautilus_banner

# Move the file to /etc/motd:
sudo mv /tmp/nautilus_banner /etc/motd
sudo chmod 0644 /etc/motd

# Repeat these steps for all required servers.
# Verify the MOTD on each server:
cat /etc/motd

## using ansible
sudo yum update -y
sudo yum install ansible -y

## for key checking
export ANSIBLE_HOST_KEY_CHECKING=False



```