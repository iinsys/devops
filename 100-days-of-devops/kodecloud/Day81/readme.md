Day 81: Jenkins Multistage Pipeline

>Neither comprehension nor learning can take place in an atmosphere of anxiety.
>
>– Rose Kennedy

The development team of xFusionCorp Industries is working on to develop a new static website and they are planning to deploy the same on Nautilus App Servers using Jenkins pipeline. They have shared their requirements with the DevOps team and accordingly we need to create a Jenkins pipeline job. Please find below more details about the task:



Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username **`admin`** and password **`Adm!n321`**.


Similarly, click on the Gitea button on the top bar to access the Gitea UI. Login using username **`sarah`** and password **`Sarah_pass123`**.


There is a repository named **`sarah/web`** in Gitea that is already cloned on Storage server under **`/var/www/html`** directory.


Update the content of the file **`index.html`** under the same repository to **`Welcome to xFusionCorp Industries`** and push the changes to the origin into the **`master`** branch.


Apache is already installed on all app Servers its running on port **`8080`**.


Create a Jenkins pipeline job named **`deploy-job`** (it must not be a Multibranch pipeline job) and pipeline should have two stages **`Deploy`** and **`Test`** ( names are case sensitive ). Configure these stages as per details mentioned below.


a. The **`Deploy`** stage should deploy the code from web repository under **`/var/www/html`** on the Storage Server, as this location is already mounted to the document root **`/var/www/html`** of all app servers.


b. The **`Test`** stage should just test if the app is working fine and website is accessible. Its up to you how you design this stage to test it out, you can simply add a curl command as well to run a curl against the LBR URL (**`http://stlb01:8091`**) to see if the website is working or not. Make sure this stage fails in case the website/app is not working or if the Deploy stage fails.


Click on the App button on the top bar to see the latest changes you deployed. Please make sure the required content is loading on the main URL **`http://stlb01:8091`** i.e there should not be a sub-directory like **`http://stlb01:8091/web`** etc.


Note:


You might need to install some plugins and restart Jenkins service. So, we recommend clicking on **`Restart Jenkins`** when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also, Jenkins UI sometimes gets stuck when Jenkins service restarts in the back end. In this case, please make sure to refresh the UI page.


For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as **loom.com** to record and share your work.

## Solution

### Step-by-Step Implementation:

**Step 1: Update and Install Required Jenkins Plugins**
```bash
# Go to Dashboard > Manage Jenkins > Plugins > Available
# First, update all existing plugins:
# - Check "Select All" > Hit "Update" Button
# - Wait for updates to complete

# Install required plugins:
# Search and install these plugins (then restart Jenkins):
# - Git plugin (usually pre-installed)
# - SSH plugin  
# - SSH Agent plugin
# - SSH Build Agents plugin
# - Pipeline plugin (usually pre-installed)
# - SSH Pipeline Steps plugin

# Check "Restart Jenkins when installation is complete and no jobs running"
# Note: Jenkins UI may get stuck during restart - refresh page if needed
```

**Step 2: Prepare Jenkins Environment**
```bash
# Connect to Jenkins server and install sshpass if not available(Optional):
ssh jenkins@jenkins    # Password: j@rv!s
sshpass -V             # Check if sshpass is installed
sudo yum install sshpass -y    # RHEL/CentOS
# OR
sudo apt install sshpass -y    # Ubuntu/Debian
exit
```

**Step 3: Update Repository Content First**
```bash
# IMPORTANT: Update index.html content BEFORE creating pipeline
# Method 1: Via Gitea UI (Recommended)
# 1. Login to Gitea: sarah/Sarah_pass123
# 2. Navigate to sarah/web repository  
# 3. Click on index.html file
# 4. Click Edit button
# 5. Change content to: "Welcome to xFusionCorp Industries"
# 6. Commit changes with message: "Update welcome message"

# Method 2: Via SSH to storage server
ssh natasha@ststor01   # Password: Bl@kW
sudo chown natasha:natasha /var/www/html/index.html
sudo chmod 755 /var/www/html/index.html
cd /var/www/html
echo "Welcome to xFusionCorp Industries" | sudo tee index.html
sudo chown natasha:natasha index.html  
sudo chmod 755 index.html
git add index.html
git commit -m "Update welcome message"
git push origin master
# Username: sarah
# Password: Sarah_pass123
```

**Step 4: Create Pipeline Job**
```bash
# Jenkins UI Steps:
# 1. New Item → "deploy-job" → Pipeline → OK
# 2. Description: "Deploy web application with two-stage pipeline"
# 3. Pipeline Definition: Pipeline script
# 4. Copy and paste the pipeline script below into the Script text area:
```

```groovy
pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                
                // Clone the repository (no credentials needed for public repo)
                git url: 'http://git.stratos.xfusioncorp.com/sarah/web.git', branch: 'master'
                
                // Copy files to storage server using shell commands
                sh '''
                    echo "Deploying files to storage server..."
                    
                    # Method 1: If Jenkins can access shared storage directly
                    if [ -d "/var/www/html" ] && [ -w "/var/www/html" ]; then
                        echo "Direct access to shared storage"
                        cp -r * /var/www/html/
                        echo "Direct copy completed"
                    else
                        # Method 2: Using SCP 
                        echo "Using SCP to transfer files"
                        
                        # First, verify what content we have locally
                        echo "DEBUG: Local index.html content:"
                        cat index.html || echo "No index.html found locally"
                        
                        # Transfer files
                        sshpass -p "Bl@kW" scp -o StrictHostKeyChecking=no -r index.html natasha@ststor01:/var/www/html/
                        
                        # Verify content on remote server
                        echo "DEBUG: Remote index.html content:"
                        sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no natasha@ststor01 "cat /var/www/html/index.html"
                        
                        # Fix permissions using echo to pass password to sudo
                        echo "Bl@kW" | sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no natasha@ststor01 "sudo -S chown -R apache:apache /var/www/html 2>/dev/null || true"
                        echo "Bl@kW" | sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no natasha@ststor01 "sudo -S chmod -R 755 /var/www/html 2>/dev/null || true"
                        
                        echo "SCP deployment completed"
                    fi
                    
                    echo "Deployment completed successfully"
                '''
            }
        }

        stage('Test') {
            steps {
                echo 'Testing deployment...'
                
                script {
                    def expectedContent = 'Welcome to xFusionCorp Industries'
                    
                    // Wait a moment for deployment to propagate
                    sleep(5)
                    
                    try {
                        // Test Load Balancer URL
                        def lbResponse = sh(script: 'curl -s http://stlb01:8091/', returnStdout: true).trim()
                        echo "DEBUG: Load balancer response: ${lbResponse}"
                        echo "DEBUG: Expected content: ${expectedContent}"
                        
                        if (!lbResponse.contains(expectedContent)) {
                            error("Load balancer test failed. Expected content '${expectedContent}' not found in response: '${lbResponse}'")
                        }
                        echo " Load balancer test passed"
                        
                        // Test individual app servers
                        ['stapp01:8080', 'stapp02:8080', 'stapp03:8080'].each { server ->
                            def response = sh(script: "curl -s http://${server}/", returnStdout: true).trim()
                            if (!response.contains(expectedContent)) {
                                error("App server ${server} test failed")
                            }
                            echo " ${server} test passed"
                        }
                        
                        echo 'All tests passed successfully!'
                        
                    } catch (Exception e) {
                        error("Test stage failed: ${e.getMessage()}")
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
```

```bash
# 5. Save the job
```

**Step 5: Run and Verify Pipeline**
```bash
# 1. Save the pipeline job
# 2. Click "Build Now" 
# 3. Monitor Console Output for both Deploy and Test stages
# 4. Verify Deploy stage: Git clone → SSH transfer → File permissions
# 5. Verify Test stage: Load balancer test → App servers test
# 6. Access http://stlb01:8091 to confirm deployment
# 7. Verify content shows "Welcome to xFusionCorp Industries"
```

### Troubleshooting Tips - Common Issues and Solutions:

```bash
# Common Issues and Solutions:
# 1. Git authentication failure: Verify repository URL and credentials
# 2. Missing SSH Pipeline Steps plugin: Install and restart Jenkins if needed  
# 3. SSH connection failure: Check SSH credentials (natasha/Bl@kW) and connection settings
# 4. Apache not responding: Ensure httpd is running and listening on port 8080
# 5. Content not updated: Verify deployment copied all files to the correct location
# 6. Test stage fails: Ensure deployed content exactly matches expected output
# 7. Strict output check: Must be case-sensitive with no extra whitespace — "Welcome to xFusionCorp Industries"

# Manual Commands for Verification:
curl -I http://stlb01:8091        # Check HTTP response headers from load balancer
curl http://stlb01:8091           # Retrieve and inspect content served by load balancer

# Test connectivity and content from individual application servers:
curl http://stapp01:8080          # App Server 1
curl http://stapp02:8080          # App Server 2  
curl http://stapp03:8080          # App Server 3

# Verify deployment on storage server:
ssh natasha@ststor01              # Password: Bl@kW
ls -la /var/www/html/
cat /var/www/html/index.html
```

### Key Success Indicators:

```bash
# Pipeline Success Criteria:
# Deploy Stage: Git clone successful, SSH file transfer completed, correct file permissions set
# Test Stage: Load balancer functionality test passed, application servers respond correctly
#  Content Verification: http://stlb01:8091 displays exactly "Welcome to xFusionCorp Industries"
#  No sub-directories in URL (not http://stlb01:8091/web)

# Final Validation:
# Access http://stlb01:8091 and verify page displays: "Welcome to xFusionCorp Industries"
```
