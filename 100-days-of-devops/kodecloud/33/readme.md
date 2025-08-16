Day 33: Resolve Git Merge Conflicts

>I can and I will. Watch me.
>
>– Carrie Green

Sarah and Max were working on writting some stories which they have pushed to the repository. Max has recently added some new changes and is trying to push them to the repository but he is facing some issues. Below you can find more details: SSH into storage server using user `max` and password `Max_pass123`. Under `/home/max` you will find the story-blog repository. Try to push the changes to the origin repo and fix the issues. The `story-index.txt` must have titles for all 4 stories. Additionally, there is a typo in The Lion and the `Mooose` line where `Mooose` should be `Mouse`. 
- Click on the `Gitea UI` button on the top bar. You should be able to access the Gitea page. You can login to `Gitea server from UI` using username `sarah` and password `Sarah_pass123` or username `max` and password `Max_pass123`.

`Note:` For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.

## Solution 

```bash
# Step 1: SSH into Jump Host
ssh thor@jump_host.stratos.xfusioncorp.com
# password: mjolnir123

# Step 2: SSH into Storage Server as max
ssh max@ststor01.stratos.xfusioncorp.com
# password: Max_pass123

# Step 3: Go to repository location
cd /home/max/story-blog

# Step 4: Check git status to see pending changes
git status

# Step 5: Try pushing to origin (may fail due to conflicts)
git push origin master

# Step 6: If push fails, pull latest changes with rebase
git pull --rebase origin master

# Step 7: Fix content issues
# Open story-index.txt in your editor and make sure it lists all 4 stories
# Also fix the typo:
# Change "The Lion and the Mooose" -> "The Lion and the Mouse"
nano story-index.txt   # or use vi

# Step 8: Stage and commit the fixes
git add story-index.txt
git commit -m "Fix typo in story index and ensure all 4 stories are listed"

# Step 9: Push changes back to origin
git push origin master

# Step 10: Verify on Gitea UI
# Open Gitea web portal
# Login with:
#   Username: max
#   Password: Max_pass123
# or use sarah/Sarah_pass123
# Confirm story-index.txt is updated with all 4 stories and typo is fixed
```