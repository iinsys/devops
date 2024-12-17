In response to heightened security concerns, the xFusionCorp Industries security team has opted for custom Apache users for their web applications. Each user is tailored specifically for an application, enhancing security measures. Your task is to create a custom Apache user according to the outlined specifications:

a. Create a user named ravi on `App server 1` within the Stratos Datacenter.

b. Assign a unique UID 1069 and designate the home directory as `/var/www/ravi.`

## Solution
```bash
## ssh to app server 1
ssh tony@stapp01.stratos.xfusioncorp.com
Password: Ir0nM@n


# Step 3: Create the Custom User
# Creates a new user 'ravi' with UID 1069 and home directory /var/www/ravi
sudo useradd -u 1069 -d /var/www/ravi -m ravi

# Step 4: Verify the User
# Checks the user details and home directory
id ravi
ls -ld /var/www/ravi

# Step 5: Assign a Password (Optional)
# Sets a password for the user 'ravi'
sudo passwd ravi

# Step 6: Exit the Server
# Exits the current session
exit
```
