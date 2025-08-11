Day 28: Git Cherry Pick

>To master a new technology, you will have to play with it.
>
>– Jordan Peterson

The Nautilus application development team has been working on a project repository `/opt/games.git`. This repo is cloned at `/usr/src/kodekloudrepos` on storage server in Stratos DC. They recently shared the following requirements with the DevOps team:

There are two branches in this repository, `master` and `feature`. One of the developers is working on the feature branch and their work is still in progress, however they want to merge one of the commits from the feature branch to the master branch, the message for the commit that needs to be merged into master is `Update info.txt`. Accomplish this task for them, also remember to push your changes eventually.

## Solution
```bash
## Step 2: SSH into Storage Server
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

## Step 3: Go to the games repo location
cd /usr/src/kodekloudrepos/games

## Step 4: Mark repo as safe to avoid 'dubious ownership' error
sudo git config --global --add safe.directory /usr/src/kodekloudrepos/games

## Step 5: Ensure you are on the master branch
sudo git checkout master

## Step 6: Find the commit hash in the feature branch with message "Update info.txt"
sudo git log feature --oneline --grep="Update info.txt"
# Example output:
# abc1234 Update info.txt
# Here, abc1234 is the commit hash we need

## Step 7: Cherry-pick that commit into master
sudo git cherry-pick abc1234
# Replace abc1234 with the actual commit hash found in Step 6

## Step 8: Push changes to origin master
sudo git push origin master

```




