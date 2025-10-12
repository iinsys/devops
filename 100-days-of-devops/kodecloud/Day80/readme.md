**Day 80: Jenkins Chained Builds**

>Practice as if you are the worst, Perform as if you are the best.

>The only thing standing between you and outrageous success is continuous progress.
>– Dan Waldschmidt

The DevOps team was looking for a solution where they want to **restart Apache service on all app servers** if the deployment goes fine on these servers in Stratos Datacenter. After having a discussion, they came up with a solution to use **Jenkins chained builds** so that they can use a **downstream job** for services which should only be triggered by the **deployment job**. So as per the requirements mentioned below configure the required Jenkins jobs.

Click on the Jenkins button on the top bar to access the Jenkins UI. Login using **username admin** and **password Adm!n321**.


Similarly you can access **Gitea UI** with username and password for Git is **sarah** and **Sarah_pass123** respectively. Under user sarah you will find a repository named **web**.


Apache is already installed and configured on all app server so no changes are needed there. The doc root **/var/www/html** on all these app servers is shared among the **Storage server** under **/var/www/html** directory.


1. Create a Jenkins job named **nautilus-app-deployment** and configure it to pull change from the **master branch** of **web** repository on **Storage server** under **/var/www/html** directory, which is already a **local git repository** tracking the origin web repository. Since **/var/www/html** on Storage server is a **shared volume** so changes should **auto reflect on all apps**.


2. Create another Jenkins job named **manage-services** and make it a **downstream** job for **nautilus-app-deployment** job. Things to take care about this job are:


a. This job should **restart httpd service** on **all app servers**.

b. Trigger this job **only if** the upstream job i.e **nautilus-app-deployment** is **stable**.


LB server is already configured. Click on the App button on the top bar to access the app. You should be able to see the latest changes you made. Please make sure the required content is loading on the **main URL `https://<LBR-URL>`** i.e there **should not be a sub-directory** like `https://<LBR-URL>/web` etc.


Note:


1. You might need to **install some plugins** and **restart Jenkins** service. So, we recommend clicking on **Restart Jenkins** when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also some times Jenkins UI gets stuck when Jenkins service restarts in the back end so in such case please **refresh the UI page**.


2. Make sure Jenkins job **passes even on repetitive runs** as validation may try to build the job multiple times.


3. Deployment related tasks should be done by **sudo user** on the destination server to avoid any permission issues so make sure to configure your Jenkins job accordingly.


4. For these kind of scenarios requiring changes to be done in a web UI, please **take screenshots** so that you can share it with us for review in case your task is marked incomplete. You may also consider using a **screen recording software** such as **loom.com** to record and share your work.

## Solution

### Step 0: Automated sudo setup (optional - use Ansible)
```bash
## install ansible on jump host
chmod +x install.sh
./install.sh

# set sudo with ansible you can find files in this directory 
ansible-playbook -i inventory.ini ansible-passwordless-sudo.yml
```

### Manual Steps (Proven Working Solution)

**Step 1: Enable passwordless sudo in all app servers (CRITICAL)**
```bash
# SSH to each app server and run:
# stapp01 (tony):
sudo visudo
# Add at the end: tony ALL=(ALL) NOPASSWD: ALL

# stapp02 (steve):
sudo visudo  
# Add at the end: steve ALL=(ALL) NOPASSWD: ALL

# stapp03 (banner):
sudo visudo
# Add at the end: banner ALL=(ALL) NOPASSWD: ALL
```

**Step 2: Install Required Jenkins Plugins**
- Jenkins UI → Manage Jenkins → Manage Plugins → Available
- Install and restart Jenkins after each group:
  - **Git plugin**
  - **SSH plugin** 
  - **Publish Over SSH plugin**
  - **Build Authorization Token Root** (optional, for webhooks)

**Step 3: Setup Jenkins Credentials** 
- Manage Jenkins → Manage Credentials → Global → Add Credentials
- Add Username/Password credentials:
  - **sarah** / Sarah_pass123 (ID: sarah) - for Git
  - **tony** / Ir0nM@n (ID: tony) - for stapp01
  - **steve** / Am3ric@ (ID: steve) - for stapp02  
  - **banner** / BigGr33n (ID: banner) - for stapp03
  - **natasha** / Bl@kW (ID: natasha) - for ststor01

**Step 4: Configure SSH Remote Hosts**
- Manage Jenkins → Configure System → SSH Remote Hosts
- Add hosts:
  - **stapp01** (172.16.238.10:22, credentials: tony, pty: ✓)
  - **stapp02** (172.16.238.11:22, credentials: steve, pty: ✓) 
  - **stapp03** (172.16.238.12:22, credentials: banner, pty: ✓)

**Step 5: Configure Publish Over SSH**
- Same page → Publish over SSH → SSH Servers → Add:
  - **Name:** ststor01
  - **Hostname:** ststor01 (or 172.16.238.15)
  - **Username:** natasha  
  - **Remote Directory:** /var/www/html
  - **Advanced:** ✓ Use password authentication
  - **Password:** Bl@kW
  - **Test Configuration** to verify

**Step 6: Create nautilus-app-deployment Job**
- New Item → nautilus-app-deployment → Freestyle Project
- **Source Code Management:**
  - Git
  - Repository URL: `http://git.stratos.xfusioncorp.com/sarah/web.git`
  - Credentials: sarah
  - Branch: */master
- **Build Environment:**
  - ✓ Send files or execute commands over SSH after the build runs
  - SSH Server: ststor01
  - Transfer Set:
    - Source files: `**/*`
    - Remove prefix: (empty)
    - Remote directory: (empty - uses /var/www/html)
    - Exec command: (empty for file transfer)

**Step 7: Create manage-services Job** 
- New Item → manage-services → Freestyle Project
- **Build Triggers:**
  - ✓ Build after other projects are built
  - Projects to watch: nautilus-app-deployment
  - ✓ Trigger only if build is stable
- **Build Steps:** Add 3 separate "Execute shell script on remote host using SSH":
  - **SSH Site 1:** tony@stapp01:22
  - **SSH Site 2:** steve@stapp02:22  
  - **SSH Site 3:** banner@stapp03:22
  - **Command for all:**
```bash
sudo systemctl restart httpd && sudo systemctl status httpd --no-pager
```

**Step 8: Link Jobs (Post-build Action)**
- Go back to nautilus-app-deployment → Configure
- **Post-build Actions:** 
  - ✓ Build other projects
  - Projects to build: manage-services
  - ✓ Trigger only if build is stable

**Step 9: Test the Pipeline**
- Build nautilus-app-deployment manually
- Verify manage-services triggers automatically
- Check app servers serve content via load balancer

### Infrastructure Summary
```bash
# Servers:
# - Jenkins: 172.16.238.19 (admin/Adm!n321)
# - Storage: ststor01 172.16.238.15 (natasha/Bl@kW) 
# - Apps: stapp01-03 172.16.238.10-12 (tony,steve,banner)
# - Git: http://git.stratos.xfusioncorp.com/sarah/web.git (sarah/Sarah_pass123)
# - LB: Access via App button in lab interface

# Key Success Factors:
# 1. NOPASSWD sudo is essential for Jenkins SSH operations
# 2. Use Git SCM in Jenkins (not manual git commands)
# 3. Publish Over SSH transfers files automatically
# 4. SSH Remote Hosts handles service restarts
# 5. Proper credentials management in Jenkins
```

