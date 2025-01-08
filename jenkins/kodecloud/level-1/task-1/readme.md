The DevOps team at xFusionCorp Industries is initiating the setup of CI/CD pipelines and has decided to utilize Jenkins as their server. Execute the task according to the provided requirements:

- 1. Install jenkins on jenkins server using yum utility only, and start its service. You might face timeout issue while starting the Jenkins service, please refer this link for help.

- 2. Jenkin's admin user name should be theadmin, password should be Adm!n321, full name should be Ammar and email should be ammar@jenkins.stratos.xfusioncorp.com.

**Note:**
- 1. For this task, access the Jenkins server by SSH using the root user and password S3curePass from the jump host.

- 2. After Jenkins server installation, click the Jenkins button on the top bar to access the Jenkins UI and follow on-screen instructions to create an admin user.

### Solution
```bash
## Connect to Jenkins server
sh root@<jenkins-server-ip>
# Password: S3curePass

sudo chmod +x install.sh
bash install.sh

# to see the default admin password
 cat /var/lib/jenkins/secrets/initialAdminPassword
 
```