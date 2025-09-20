Day 26: Git Manage Remotes

The xFusionCorp development team added updates to the project that is maintained under /opt/beta.git repo and cloned under /usr/src/kodekloudrepos/beta. Recently some changes were made on Git server that is hosted on Storage server in Stratos DC. The DevOps team added some new Git remotes, so we need to update remote on /usr/src/kodekloudrepos/beta repository as per details mentioned below:


a. In /usr/src/kodekloudrepos/beta repo add a new remote dev_beta and point it to /opt/xfusioncorp_beta.git repository.


b. There is a file /tmp/index.html on same server; copy this file to the repo and add/commit to master branch.


c. Finally push master branch to this new remote origin.

## Solution
```bash
## Step 2: SSH into Storage Server
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

## Step 3: Go to beta repo location
cd /usr/src/kodekloudrepos/beta

## Step 4: Mark repo as safe to avoid 'dubious ownership' error
sudo git config --global --add safe.directory /usr/src/kodekloudrepos/beta

## Step 5: Add the new remote (with sudo to avoid permission issues)
sudo git remote add dev_beta /opt/xfusioncorp_beta.git

## Step 6: Verify remote was added
sudo git remote -v
# Expected: dev_beta pointing to /opt/xfusioncorp_beta.git

## Step 7: Copy the file /tmp/index.html into repo
sudo cp /tmp/index.html .

## Step 8: Stage and commit the file to master branch
sudo git add index.html
sudo git commit -m "Add index.html from /tmp to beta repo"

## Step 9: Push master branch to new remote
sudo git push dev_beta master
```