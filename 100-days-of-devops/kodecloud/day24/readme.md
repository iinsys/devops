Day 24: Git Create Branches

>One big reason for a winning attitude is that you will take the necessary steps and not quit when the going gets difficult.
>
>– Don M.Green

Nautilus developers are actively working on one of the project repositories, `/usr/src/kodekloudrepos/ecommerce`. Recently, they decided to implement some new features in the application, and they want to maintain those new changes in a separate branch. Below are the requirements that have been shared with the DevOps team:



- On `Storage server` in `Stratos DC` create a new branch `xfusioncorp_ecommerce` from `master` branch in `/usr/src/kodekloudrepos/ecommerce` git repo.

>Please do not try to make any changes in the code.
## Solution 
```bash

## Step 1: SSH into Storage Server
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

## Step 2: Navigate to the Repository
cd /usr/src/kodekloudrepos/ecommerce

## Step 3: Verify Current Branch
git status
git branch

# Ensure you are on the master branch
# If not, switch to master:
git checkout master

git config --global --add safe.directory /usr/src/kodekloudrepos/ecommerce

## Step 4: Create New Branch
git checkout -b xfusioncorp_ecommerce

## Step 5: Verify New Branch Exists
git branch
# Expected output:
#   master
#   xfusioncorp_ecommerce

## Step 6: Final Verification
# Confirm branch is created successfully without modifying any code
git log --oneline --decorate --graph --all

```






