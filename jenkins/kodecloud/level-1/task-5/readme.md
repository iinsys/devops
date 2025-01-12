Some new requirements have come up to install and configure some packages on the Nautilus infrastructure under Stratos Datacenter. The Nautilus DevOps team installed and configured a new Jenkins server so they wanted to create a Jenkins job to automate this task. Find below more details and complete the task accordingly:


1. Access the Jenkins UI by clicking on the `Jenkins` button in the top bar. Log in using the credentials: username `admin` and password `Adm!n321`.


2. Create a new Jenkins job named install-packages and configure it with the following specifications:


- Add a string parameter named `PACKAGE.`
- Configure the job to install a package specified in the `$PACKAGE` parameter on the `storage server` within the `Stratos Datacenter`.

`Note:`


1. Ensure to install any required plugins and restart the Jenkins service if necessary. Opt for `Restart Jenkins when installation is complete and no jobs are running` on the plugin `installation/update` page. Refresh the UI page if needed after restarting the service.


2. Verify that the Jenkins job runs successfully on repeated executions to ensure reliability.


3. Capture screenshots of your configuration for documentation and review purposes. Alternatively, use screen recording software like `loom.com` for comprehensive documentation and sharing.

## Solution
**Steps to Configure Jenkins Job for Package Installation**

**Step 1: Access the Jenkins UI**

* Open the Jenkins web interface by clicking on the Jenkins button in the top bar.
* Login using:
    * Username: admin
    * Password: Adm!n321

**Step 2: Create a New Jenkins Job**

1. From the Jenkins dashboard, click on "New Item".
2. Enter the name of the job: "install-packages".
3. Select "Freestyle project" and click OK.
4. In the General section, you can optionally add a description for the job, such as "Automates package installation on the storage server".
5. Under the Build Triggers section, check "This project is parameterized".
6. Add a String Parameter:
    * Name: PACKAGE
    * Description: "The name of the package to install on the storage server."
    * Default value (optional): htop (or leave it empty for flexibility).

**Step 3: Add Build Step to Execute Shell Script**

1. In the Build section, click "Add build step" and select "Execute shell".
2. In the Command field, add the following shell script:

   ```bash
   #!/bin/bash
   # Check if the PACKAGE parameter is provided
   if [ -z "$PACKAGE" ]; then
       echo "Error: PACKAGE parameter is missing."
       exit 1
   fi

   # Define the target server and SSH credentials
   SERVER="172.16.238.15"
   USER="natasha"

   # Install the package on the storage server
   sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no "$USER@$SERVER" "sudo apt-get update && sudo apt-get install -y $PACKAGE"

   # Check if the package installation was successful
   if [ $? -eq 0 ]; then
       echo "Package '$PACKAGE' installed successfully on $SERVER."
   else
       echo "Failed to install package '$PACKAGE' on $SERVER."
       exit 1
   fi
```
**Step 4: Save the Jenkins Job Configuration**

* Scroll down and click "Save" to save the Jenkins job configuration.

**Step 5: Install Required Plugins (If Needed)**

1. Go to `Manage Jenkins > Manage Plugins`.
2. Under the `Available` tab, search for the following plugins:
    * `SSH Plugin`: For running commands over SSH.
    * `SSH Pass Plugin`: For passing the SSH password to make an SSH connection without manual input.
3. Select the plugins and click `Install without restart`.
4. After installation, you may need to restart Jenkins. To do this, go to `Manage Jenkins > Restart Jenkins when installation is complete and no jobs are running`.

**Step 6: Run the Jenkins Job**

1. From the Jenkins dashboard, click on the `install-packages` job.
2. Click `Build with Parameters`.
3. In the `PACKAGE` field, enter the package name you want to install (e.g., vim, wget, or htop).
4. Click `Build` to trigger the job.
5. Monitor the Execution: Once the job starts, Jenkins will execute the shell script, and you can view the logs in the `Console Output`. The script will SSH into the storage server and attempt to install the specified package.

**Step 7: Verify Package Installation**

1. After the job runs successfully, log into the storage server with the credentials:
    * User: natasha
    * IP Address: 172.16.238.15
2. Verify that the package was installed by running the corresponding command. For example, to check if htop is installed, run:
    ```bash
    htop
    ```
3. If the package is installed successfully, it should be available for use.

**Step 8: Test Job Reliability**

1. Re-run the Job: To ensure the reliability of the Jenkins job, re-run the job multiple times with different package names, such as vim, wget, etc.
2. Check the console output each time and ensure that the job completes successfully.

**Step 9: Documentation and Verification**

1. Capture screenshots of:
    * The user creation process for james.
    * The global security matrix showing permissions for james, admin, and Anonymous.
    * The job-level security settings showing james with Job -> Read permissions.
2. Optionally, use screen recording software like loom.com to document the process for sharing and review purposes.
3. Review the job and ensure that it works as expected by checking the logs and ensuring that the package installation was successful on the storage server.

**Conclusion**

The Jenkins job is now fully configured to install packages on the storage server in the Stratos Datacenter. The job accepts a package name parameter, SSHs into the server, and installs the specified package.

Also check the tutorial [link](https://www.loom.com/share/ff03c1e4cec841849efe1b2f4dfa9b7c)