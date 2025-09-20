Day 23: Fork a Git Repository

>If you can't explain it simply you don't understand it well enough.
>
>– Albert Einstein

>Losers visualize the penalties of failure, Winners visualize the rewards of success.
>
>– Dr.Rob Gilbert

There is a Git server utilized by the Nautilus project teams. Recently, a new developer named Jon joined the team and needs to begin working on a project. To begin, he must fork an existing Git repository. Follow the steps below:



- Click on the `Gitea UI` button located on the top bar to access the Gitea page.


- Login to Gitea server using username `jon` and password `Jon_pass123`.


- Once logged in, locate the Git repository named `sarah/story-blog` and fork it under the jon user.


`Note:` For tasks requiring web UI changes, screenshots are necessary for review purposes. Additionally, consider utilizing screen recording software such as loom.com to record and share your task completion process.


## Solution 
```bash
# Daily DevOps Task 23 – Fork Repository in Gitea for User Jon

## Step 1: Access Gitea UI
- From your browser on jump_host or your local machine, click on the **Gitea** button located on the top bar (or navigate directly to the Gitea URL, e.g., `http://gitea.stratos.xfusioncorp.com`).

## Step 2: Log in to Gitea
- Username: `jon`
- Password: `Jon_pass123`
- Click **Sign In**.

## Step 3: Locate the Repository
- After login, use the search bar or navigate to the `sarah/story-blog` repository.
- You can find it under the `sarah` user or organization's repositories.

## Step 4: Fork the Repository
- Open the `sarah/story-blog` repository page.
- Click the **Fork** button (usually top right corner).
- When prompted, choose your own user namespace (`jon`) as the fork destination.
- Confirm the fork operation.

## Step 5: Verify the Fork
- Once completed, you should be redirected to your fork at `jon/story-blog`.
- Confirm that the forked repo is listed in your repositories.

## Step 6: Capture Screenshots / Record
- Take screenshots of:
  - Gitea login page with username entered.
  - The original `sarah/story-blog` repository page with the Fork button.
  - The confirmation screen after forking.
  - Your forked repository page under user `jon`.
- (Optional) Record your screen using loom.com or any screen recorder to demonstrate the entire process.

## Step 7: Submit Evidence
- Upload the screenshots and/or video recording as required by your task submission guidelines.
```
[Visit here to watch the video if you not clear with the steps](https://www.loom.com/share/92053599c266430098b1518565715f41)