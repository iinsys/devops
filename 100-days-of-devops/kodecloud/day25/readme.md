Day 25: Git Merge Branches

>Study hard what interests you the most in the most undisciplined, irreverent and original manner possible.
>
>– Richard P. Feynman

The Nautilus application development team has been working on a project repository /opt/blog.git. This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared the following requirements with DevOps team:

Create a new branch nautilus in `/usr/src/kodekloudrepos/blog` repo from `master` and copy the `/tmp/index.html` file (present on storage server itself) into the repo. Further, `add/commit` this file in the new branch and merge back that branch into master branch. Finally, `push` the changes to the origin for both of the branches.

## Solution
```bash
## Step 2: SSH into Storage Server
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

## Step 3: Navigate to the cloned repo
cd /usr/src/kodekloudrepos/blog

## Step 4: Mark repo as safe (if Git shows dubious ownership error)
git config --global --add safe.directory /usr/src/kodekloudrepos/blog

## Step 5: Ensure we are on master branch
git checkout master

## Step 6: Create and switch to new branch 'nautilus'
git checkout -b nautilus

## Step 7: Copy index.html into repo
sudo cp /tmp/index.html .

## Step 8: Stage and commit the file in 'nautilus' branch
git add index.html
git commit -m "Add index.html to nautilus branch"

## Step 9: Push 'nautilus' branch to origin
sudo chown -R natasha:natasha /opt/blog.git
git push origin nautilus

## Step 10: Switch back to master branch
git checkout master

## Step 11: Merge 'nautilus' into master
git merge nautilus

## Step 12: Push updated master branch to origin
git push origin master

```