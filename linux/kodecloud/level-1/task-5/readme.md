As part of the temporary assignment to the Nautilus project, a developer named siva requires access for a limited duration. To ensure smooth access management, a temporary user account with an expiry date is needed. Here's what you need to do:

Create a user named `siva` on `App Server 1` in Stratos Datacenter. Set the expiry date to `2024-02-17`, ensuring the user is created in lowercase as per standard protocol.

### Solution
### Creating a Temporary User with Expiry Date

This guide details how to create a temporary user named `siva` on App Server 1 (stapp01) with an expiry date set to February 17th, 2024.

**Prerequisites:**

* Access credentials for the jump server (`jump_host.stratos.xfusioncorp.com`).

**Steps:**

1. **Access the Jump Server (ssh thor@jump_host.stratos.xfusioncorp.com):**

   ```bash
   ssh thor@jump_host.stratos.xfusioncorp.com
   Password: mjolnir123  # Replace with your actual password (not recommended to store passwords in plain text)
   ```
2 **Access App Server 1 (ssh tony@stapp01.stratos.xfusioncorp.com):**
```bash
ssh tony@stapp01.stratos.xfusioncorp.com
Password: Ir0nM@n  # Replace with your actual password (not recommended to store passwords in plain text)
```
3 **Create the User:**
```bash
sudo useradd -e 2024-02-17 siva  # Creates user 'siva' with expiry date set to Feb 17, 2024
```
4 **Set a Password for the User:**
```bash
sudo passwd siva  # Enter a strong password when prompted (avoid the example 'temporaryPassword')
```
5 **Verify the User's Expiry Date:**
```bash
sudo chage -l siva  # Check if the expiry date is set correctly
exit
```