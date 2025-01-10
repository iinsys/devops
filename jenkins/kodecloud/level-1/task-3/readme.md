The Nautilus team is integrating Jenkins into their CI/CD pipelines. After setting up a new Jenkins server, they're now configuring user access for the development team, Follow these steps:



1. Click on the `Jenkins` button on the top bar to access the Jenkins UI. Login with username `admin` and password `Adm!n321`.

2. Create a jenkins user named `mariyam` with the password `YchZHRcLkL`. Their full name should match `Mariyam`.

3. Utilize the `Project-based Matrix Authorization Strategy` to assign overall read permission to the mariyam user.

4. Remove all permissions for `Anonymous` users (if any) ensuring that the `admin` user retains overall `Administer` permissions.

5. For the existing job, grant `mariyam` user only `read` permissions, disregarding other permissions such as Agent, SCM etc.


`Note:`

1. You may need to install plugins and restart Jenkins service. After plugins installation, select `Restart Jenkins when installation is complete and no jobs are running` on plugin installation/update page.


2. After restarting the Jenkins service, wait for the Jenkins login page to reappear before proceeding. Avoid clicking `Finish` immediately after restarting the service.


3. Capture screenshots of your configuration for review purposes. Consider using screen recording software like `loom.com` for documentation and sharing.

## Solution
```bash
# the names might slightly differ but it is still the same concept
```
**Steps to Configure Jenkins User Access**

**Login to Jenkins**

1. Open the Jenkins web interface.
2. Login using:
    * Username: admin
    * Password: Adm!n321

**Verify Plugins**

1. Navigate to Manage Jenkins > Plugin Manager.
2. Go to the Available tab and search for the following plugin:
   * Matrix Authorization Strategy (required for matrix-based permissions).
3. Select the plugin and click Install without restart.
4. After installation, select Restart Jenkins when installation is complete and no jobs are running.

**Create a New User**

1. After Jenkins restarts, log in again as admin.
2. Go to Manage Jenkins > Manage Users.
3. Click Create User and fill in the following details:
    * Username: james
    * Password: GyQkFRVNr3
    * Confirm Password: GyQkFRVNr3
    * Full Name: James
    * Email Address: (Optional, or provide a valid email)
4. Click Create User to save.

**Enable Project-based Matrix Authorization Strategy**

1. Navigate to Manage Jenkins > Configure Global Security.
2. In the Authorization section:
    * Select Project-based Matrix Authorization Strategy.
3. Click Save.

**Configure Global Permissions**

1. Go back to Configure Global Security and scroll to the Matrix-based Security table.
2. Add users and set their permissions:
    * Add James:
        * Type james in the user field and click Add.
        * Grant Overall Read permission by checking the box under Overall -> Read.
    * Admin User:
        * Ensure admin has Overall Administer permissions.
    * Anonymous User:
        * Clear all permissions for Anonymous by unchecking all boxes in its row.
3. Click Save.

**Configure Job-level Permissions**

1. Navigate to the specific Jenkins job for which permissions need to be configured.
2. Click on the job's name and select Configure.
3. In the job's configuration page:
    * Scroll to the Security section.
    * Enable Use project-based security.
    * Add james to the list of users and grant only the following permission:
        * Job -> Read (Check this box only).
    * Remove other permissions for james like Build, Cancel, Configure, etc.
4. Click Save.

**Test the Configuration**

1. Log out of the admin account and log in as james.
2. Verify:
    * james can access the Jenkins UI and view the job list but cannot modify Jenkins or jobs.
    * james can view the specific job but cannot build, configure, or delete it.
3. Log out and log back in as admin to verify that admin retains full permissions.

**Verification Checklist**

* The james user has Overall Read globally.
* The james user has Job Read for the specific job.
* The Anonymous user has no permissions.
* The admin user retains Overall Administer permissions.

**Notes for Documentation**

* Capture screenshots of:
    * The user creation process for james.
    * The global security matrix showing permissions for james, admin, and Anonymous.
    * The job-level security settings showing james with Job -> Read permissions.
* Use a screen recording tool like loom.com to document the process for sharing and review purposes.

**Troubleshooting**

* **Missing Matrix Authorization Strategy:**
    * Install the Matrix Authorization Strategy plugin from the Plugin Manager.
    * Restart Jenkins after installation.
* **Incorrect Permissions for James:**
    * Ensure james has Overall Read in the global security settings.
    * Assign Job -> Read permission to james for specific jobs only.
* **Anonymous Users Can Access Jenkins:**
    * Verify that all permissions for Anonymous are removed in the global matrix.

By following these steps, you will successfully configure user permissions in Jenkins for james.

[Solution is in this video tutorial](https://www.loom.com/share/ec5b261f89cf4dd1819bba1fbf982943)