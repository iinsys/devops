Day 29: Manage Git Pull Requests

>Regret for the time wasted can become a power of good in the time that remains.
>
>– Arthur Brisbane

Max want to push some new changes to one of the repositories but we don't want people to push directly to master branch, since that would be the final version of the code. It should always only have content that has been reviewed and approved. We cannot just allow everyone to directly push to the master branch. So, let's do it the right way as discussed below:


SSH into storage server using user `max`, password `Max_pass123` . There you can find an already cloned repo under Max user's home.


Max has written his story about The 🦊 Fox and Grapes 🍇


Max has already pushed his story to remote git repository hosted on Gitea branch story/fox-and-grapes


Check the contents of the cloned repository. Confirm that you can see Sarah's story and history of commits by running git log and validate author info, commit message etc.


Max has pushed his story, but his story is still not in the master branch. Let's create a Pull Request(PR) to merge `Max's story/fox-and-grapes` branch into the master branch


Click on the Gitea UI button on the top bar. You should be able to access the Gitea page.


UI login info:

- Username: `max`

- Password: `Max_pass123`

`PR title : Added fox-and-grapes story`

PR pull from branch: `story/fox-and-grapes (source)`

PR merge into branch: master (destination)


Before we can add our story to the master branch, it has to be reviewed. So, let's ask tom to review our PR by assigning him as a reviewer


Add tom as reviewer through the Git Portal UI

Go to the `newly created PR`

Click on Reviewers on the right

Add tom as a `reviewer` to the PR

Now let's review and approve the PR as user Tom


Login to the portal with the user `tom`


Logout of Git Portal UI if logged in as `max`


UI login info:

- Username: `tom`

- Password: `Tom_pass123`

`PR title : Added fox-and-grapes `story`

Review and merge it.

Great stuff!! The story has been merged! 👏


>`Note:` For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.

## Solution
```bash
## Step 2: SSH into Storage Server as Max
ssh max@ststor01.stratos.xfusioncorp.com
# password: Max_pass123

## Step 3: Go to the cloned repo in Max's home
cd ~
ls -la
# You should see the repository folder (example: stories.git or similar)

## Step 4: Go inside repo and check content
cd <repo_name>
cat fox-and-grapes.txt   # or similar filename to confirm Max’s story is there

## Step 5: Check commit history for branch
git checkout story/fox-and-grapes
git log --oneline --decorate --graph --all
# Confirm commit message and author info
```
# Gitea Workflow Steps

## Step 6: Open Gitea UI
In your browser, go to the Gitea portal URL provided in your environment.
(Usually accessible via the top bar of your task interface — click the Gitea icon)

Login as:
- **Username:** max
- **Password:** Max_pass123

## Step 7: Create Pull Request (PR)
1. Go to the repository page in Gitea.
2. Click "Pull Requests" → "New Pull Request".
3. Set the following:
   - **Source branch:** story/fox-and-grapes
   - **Target branch:** master
   - **PR title:** Added fox-and-grapes story
4. Create the PR.

## Step 8: Assign Tom as Reviewer
1. Inside the PR page, look for the "Reviewers" section on the right.
2. Add tom as reviewer.

## Step 9: Logout as Max
1. Click your avatar in Gitea → "Sign out".

## Step 10: Login as Tom
1. Login with:
   - **Username:** tom
   - **Password:** Tom_pass123
2. Go to Pull Requests.
3. Open the PR titled "Added fox-and-grapes story".
4. Review the changes.
5. Approve the PR.
6. Click "Merge" to merge into master.