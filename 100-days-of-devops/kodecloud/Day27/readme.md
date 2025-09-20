Day 27: Git Revert Some Changes

>You don’t understand anything until you learn it more than one way.
>
>– Marvin Minsky

The Nautilus application development team was working on a git repository `/usr/src/kodekloudrepos/blog` present on Storage server in `Stratos DC`. However, they reported an issue with the recent commits being pushed to this repo. They have asked the DevOps team to revert repo `HEAD` to last commit. Below are more details about the task:


- In `/usr/src/kodekloudrepos/blog` git repository, revert the latest commit ( `HEAD` ) to the previous commit (`JFYI` the previous commit hash should be with initial commit message ).


- Use `revert blog` message (please use all small letters for commit message) for the new revert commit.

## Solution
```bash
## Step 2: SSH into Storage Server
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

## Step 3: Go to the blog repo
cd /usr/src/kodekloudrepos/blog

## Step 4: Mark repo as safe if 'dubious ownership' error appears
sudo git config --global --add safe.directory /usr/src/kodekloudrepos/blog

## Step 5: Check git log to see recent commits
git log --oneline

## Step 6: Revert the latest commit (HEAD) to the previous commit
git revert --no-edit HEAD

## Step 7: Amend commit message to match requirement (all lowercase)
git commit --amend -m "revert blog"

## Step 8: Push changes to remote
git push origin master

```




