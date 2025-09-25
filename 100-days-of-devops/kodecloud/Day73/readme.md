Day 73: Jenkins Scheduled Jobs

The devops team of xFusionCorp Industries is working on to setup centralised logging management system to maintain and analyse server logs easily. Since it will take some time to implement, they wanted to gather some server logs on a regular basis. At least one of the app servers is having issues with the Apache server. The team needs Apache logs so that they can identify and troubleshoot the issues easily if they arise. So they decided to create a Jenkins job to collect logs from the server. Please create/configure a Jenkins job as per details mentioned below:

**1.** Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username `admin` and password `Adm!n321`.

**2.** Create a Jenkins job named `copy-logs`.

**3.** Configure it to periodically build every 4 minutes to copy the Apache logs (both `access_log` and `error_log`) from App Server 2 (from default logs location) to location `/usr/src/dba` on Storage Server.

> **Note:**
> 1. You might need to install some plugins and restart Jenkins service. So, we recommend clicking on Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also, Jenkins UI sometimes gets stuck when Jenkins service restarts in the back end. In this case please make sure to refresh the UI page.
> 2. Please make sure to define your cron expression like this `*/10 * * * *` (this is just an example to run job every 10 minutes).
> 3. For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.

## Solution
```bash
# 1) Access the Jenkins UI
# Open your browser and go to: http://jenkins.stratos.xfusioncorp.com:8080
# Login with:
#   Username: admin
#   Password: Adm!n321

# 2) Create a new job
# - Click "New Item"
# - Enter the name: copy-logs
# - Select "Freestyle project" and click OK

# 3) Configure periodic build
# - Check "Build periodically"
# - Enter the cron expression: */4 * * * *
#   (This will run the job every 4 minutes)

# 4) Add a build step to copy Apache logs
# - Add a "Build" step: "Execute shell"
# - Command example (adjust as needed for your environment):
sshpass -p 'Am3ric@' scp -o StrictHostKeyChecking=no steve@stapp02.stratos.xfusioncorp.com:/var/log/httpd/access_log .
sshpass -p 'Am3ric@' scp -o StrictHostKeyChecking=no steve@stapp02.stratos.xfusioncorp.com:/var/log/httpd/error_log .
sshpass -p 'Bl@kW' scp -o StrictHostKeyChecking=no access_log error_log natasha@ststor01.stratos.xfusioncorp.com:/usr/src/dba/
rm -f access_log error_log
  
#   # Use the correct username (natasha) for Storage Server
#   # Ensure SSH keys or passwordless access is set up from Jenkins/App Server 2 to Storage Server

# 5) Save the job

# 6) (Optional) Capture screenshots or record your steps for documentation or review
```