Day 21: Set Up Git Repository on Storage Server

>Question everything. Learn something. Answer nothing.
>
>– Euripides

The Nautilus development team has provided requirements to the DevOps team for a new application development project, specifically requesting the establishment of a Git repository. Follow the instructions below to create the Git repository on the Storage server in the Stratos DC:



- Utilize `yum` to install the `git` package on the `Storage Server`.


- Create a bare repository named `/opt/apps.git` (ensure exact name usage).

## Solution
```bash
## Step 1: SSH into Storage Server
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

## Step 2: Install git package
sudo yum install git -y

## Step 3: Create the bare git repository directory
sudo mkdir -p /opt/apps.git

## Step 4: Initialize a bare git repository
sudo git init --bare /opt/apps.git

## Step 5: Verify the repository creation
sudo ls -l /opt/apps.git
# You should see directories like branches, hooks, objects, refs inside /opt/apps.git

```
