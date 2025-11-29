# Day 5 — AWS EBS Volume Creation (Wizard Method)

>You never know what you can do until you try.
>
>– William Cobbett

## Task Description

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units. This granular approach enables the team to execute the migration in gradual phases, ensuring smoother implementation and minimizing disruption to ongoing operations. By breaking down the migration into smaller tasks, the Nautilus DevOps team can systematically progress through each stage, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

Create a volume with the following requirements:

- Name of the volume should be `xfusion-volume`.
- Volume type must be `gp3`.
- Volume size must be `2 GiB`.

## Step-by-Step Solution Using AWS Console Wizard

### Step 1 — Navigate to Create Volume

1. Log in using the provided AWS console URL, username, and password.
2. Go to **EC2 Dashboard**.
3. In the left-hand menu, scroll to **Elastic Block Store**.
4. Click **Volumes**.
5. Click **Create volume**.

### Step 2 — Configure Volume Settings

Inside the Create Volume wizard:

**1. Volume Type**
- Select `gp3` (General Purpose SSD).

**2. Size**
- Set Size = `2 GiB`.

**3. Availability Zone**
- Choose any AZ within `us-east-1`
- Example: `us-east-1a`, `us-east-1b`, etc.
- (Any is fine unless the lab specifies otherwise.)


### Step 3 — Create the Volume

1. Click **Create volume**.
2. A success message will appear showing something like:
   - Volume ID: `vol-0a123b456cd789e01`
   - Volume type: `gp3`
   - Size: `2 GiB`
 

 ### Step 4 — Edit to Add Name
1. Select the newly created volume from the list.
2. Use the edit icon to add the name:
 `xfusion-volume`

### Step 5 — Verify

Return to **Volumes** list:

- Confirm the newly created `gp3` volume appears.
- Confirm size = `2 GiB`.
- Confirm the Name tag = `xfusion-volume`.
- Confirm region = `us-east-1`.



