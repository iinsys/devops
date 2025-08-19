Day 34: Git Hook

>In learning you will teach, and in teaching you will learn.
>
>– Phil Collins

The Nautilus application development team was working on a git repository `/opt/demo.git` which is cloned under `/usr/src/kodekloudrepos` directory present on `Storage server` in `Stratos DC`. The team want to setup a hook on this repository, please find below more details:



Merge the `feature` branch into the `master` branch`, but before pushing your changes complete below point.

Create a `post-update` hook in this git repository so that whenever any changes are pushed to the `master` branch, it creates a release tag with name `release-2023-06-15`, where `2023-06-15` is supposed to be the current date. For example if today is `20th June, 2023` then the release tag must be `release-2023-06-20`. Make sure you test the hook at least once and create a release tag for today's release.

Finally remember to push your changes.

## Solution
```bash
# From the jump host, connect to the Storage Server (ststor01)
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

# --- Create the post-update hook in the bare repo ---
cd /opt/demo.git/hooks

# Create the hook (formatted correctly; POSIX sh; correct string comparison; correct tag name)
sudo tee post-update > /dev/null << 'EOF'
#!/bin/sh
# post-update is invoked with a list of refs that were updated
# We check if the first updated ref is master (simple case)
if [ "$1" = "refs/heads/master" ]; then
  echo "creating release tag"
  # Tag format: release-YYYY-MM-DD (today's date), pointing to master
  git tag "release-$(date '+%Y-%m-%d')" master
fi
EOF

# Make it executable
sudo chmod +x /opt/demo.git/hooks/post-update

# Optional: verify hook file
ls -l /opt/demo.git/hooks/post-update

# --- Merge feature into master in the working clone and push ---
cd /usr/src/kodekloudrepos/demo

# Ensure we’re on master, merge feature, then push to trigger the hook
git checkout master
git merge feature
git push origin master

# --- Verify the release tag was created in the bare repo (/opt/demo.git) ---
cd /opt/demo.git

# Fetch (OK if there are no remotes configured)
sudo git fetch --all

# List tags; you should see: release-YYYY-MM-DD
sudo git tag

```