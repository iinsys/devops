Day 30: Git hard reset

>Be not in despair, the way is very difficult, like walking on the edge of a razor; yet despair not, arise, awake, and find the ideal, the goal.
>
>– Swami Vivekananda

The Nautilus application development team was working on a git repository `/usr/src/kodekloudrepos/official` present on Storage server in Stratos DC. This was just a test repository and one of the developers just pushed a couple of changes for testing, but now they want to clean this repository along with the commit `history/work` tree, so they want to point back the HEAD and the branch itself to a commit with message add data.txt file. Find below more details:



1. In `/usr/src/kodekloudrepos/official` git repository, reset the git commit history so that there are only two commits in the commit history i.e initial commit and add `data.txt` file.


2. Also make sure to push your changes.

## Solution
```bash
## Step 2: SSH into Storage Server
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

## Step 3: Go to the official repo
cd /usr/src/kodekloudrepos/official

## Step 4: Allow safe directory (avoid 'dubious ownership' error)
sudo git config --global --add safe.directory /usr/src/kodekloudrepos/official

## Step 5: Check commit history and find commit hash for "add data.txt file"
sudo git log --oneline
# Example output:
# a1b2c3d (HEAD -> master, origin/master) some testing commit
# 4f5e6g7 add data.txt file
# 1234567 initial commit

## Step 6: Hard reset to "add data.txt file" commit (replace <commit_hash> below)
sudo git reset --hard <commit_hash>

## Step 7: Force push changes to remote
sudo git push origin master --force

## Step 8: Verify only two commits remain
sudo git log --oneline
# Expected:
# <commit_hash> add data.txt file
# <commit_hash> initial commit
```