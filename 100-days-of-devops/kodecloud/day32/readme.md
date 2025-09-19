Day 32: Git Rebase

>Neither comprehension nor learning can take place in an atmosphere of anxiety.
>
>– Rose Kennedy

The Nautilus application development team has been working on a project repository `/opt/news.git`. This repo is cloned at `/usr/src/kodekloudrepos` on storage server in `Stratos DC`. They recently shared the following requirements with DevOps team:



One of the developers is working on `feature` branch and their work is still in progress, however there are some changes which have been pushed into the `master` branch, the developer now wants to `rebase` the `feature` branch with the `master` branch without loosing any data from the `feature` branch, also they don't want to add any merge commit by simply merging the master branch into the `feature` branch. Accomplish this task as per requirements mentioned.


Also remember to push your changes once done.

## Solution
```bash
## Step 2: SSH into Storage Server
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

## Step 3: Go to the repo location
cd /usr/src/kodekloudrepos/news

## Step 4: Allow safe directory (avoid 'dubious ownership' error)
sudo git config --global --add safe.directory /usr/src/kodekloudrepos/news

## Step 5: Fetch latest updates from origin
sudo git fetch origin

## Step 6: Checkout the feature branch
sudo git checkout feature

## Step 7: Rebase feature branch onto master (no merge commit, keeps linear history)
sudo git rebase master

## Step 8: Push the rebased feature branch to origin
sudo git push origin feature --force-with-lease
```

