Day 31: Git Stash

>Whatever we believe about ourselves and our ability comes true for us.
>
>– Susan L. Taylor

The Nautilus application development team was working on a git repository `/usr/src/kodekloudrepos/demo` present on `Storage server` in `Stratos DC`. One of the developers stashed some in-progress changes in this repository, but now they want to restore some of the stashed changes. Find below more details to accomplish this task:

Look for the stashed changes under `/usr/src/kodekloudrepos/demo` git repository, and restore the stash with `stash@{1}` identifier. Further, commit and push your changes to the origin.

## Solution
```bash
## Step 2: SSH into Storage Server
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

## Step 3: Go to the demo repo
cd /usr/src/kodekloudrepos/demo

## Step 4: Allow safe directory (avoid 'dubious ownership' error)
sudo git config --global --add safe.directory /usr/src/kodekloudrepos/demo

## Step 5: Check stash list
sudo git stash list
# Look for stash@{1}

## Step 6: Apply the specific stash (stash@{1})
sudo git stash apply stash@{1}

## Step 7: Stage and commit the restored changes
sudo git add .
sudo git commit -m "restore stash@{1} changes"

## Step 8: Push the changes to origin
sudo git push origin master

```