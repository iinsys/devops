# Day 38 – Deploying a Containerized Application with ECR & ECS

> Success doesn't come to you, you go to it.
>
> – Marva Collins

## Task Description

The Nautilus DevOps team is tasked with deploying a containerized application using Amazon's container services. They need to create a private Amazon Elastic Container Registry (ECR) to store their Docker images and use Amazon Elastic Container Service (ECS) to deploy the application. The process involves building a Docker image from a given Dockerfile, pushing it to the ECR, and then setting up an ECS cluster to run the application.

### Create a Private ECR Repository:
- Create a private ECR repository named `nautilus-ecr` to store Docker images.

### Build and Push Docker Image:
- Use the Dockerfile located at `/root/pyapp` on the aws-client host.
- Build a Docker image using this Dockerfile.
- Tag the image with `latest` tag.
- Push the Docker image to the `nautilus-ecr` repository.

### Create and Configure ECS cluster:
- Create an ECS cluster named `nautilus-cluster` using the Fargate launch type.

### Create an ECS Task Definition:
- Define a task named `nautilus-taskdefinition` using the Docker image from the `nautilus-ecr` ECR repository.
- Specify necessary CPU and memory resources.

### Deploy the Application Using ECS Service:
- Create a service named `nautilus-service` on the `nautilus-cluster` to run the task.
- Ensure the service runs at least one task.

## Requirements

| Requirement             | Value                        |
|------------------------|------------------------------|
| Region                 | `us-east-1`                  |
| ECR Repository Name    | `nautilus-ecr`               |
| ECS Cluster Name       | `nautilus-cluster`           |
| Task Definition Name   | `nautilus-taskdefinition`    |
| Service Name           | `nautilus-service`           |
| Launch Type            | Fargate                      |
| Dockerfile Location    | `/root/pyapp`                |
| Image Tag              | `latest`                     |

## Solution (Using AWS CLI)

### Step 1: Define Environment Variables

```bash
REGION="us-east-1"

ECR_REPO="nautilus-ecr"
CLUSTER_NAME="nautilus-cluster"
TASK_DEF_NAME="nautilus-taskdefinition"
SERVICE_NAME="nautilus-service"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
IMAGE_TAG="latest"
IMAGE_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$ECR_REPO:$IMAGE_TAG"
```

### Step 2: Create a Private ECR Repository

```bash
aws ecr create-repository \
  --repository-name $ECR_REPO \
  --region $REGION
```

Verify:

```bash
aws ecr describe-repositories \
  --repository-names $ECR_REPO \
  --region $REGION
```

### Step 3: Authenticate Docker to ECR

```bash
aws ecr get-login-password --region $REGION | \
docker login --username AWS --password-stdin \
$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
```

Expected output: `Login Succeeded`

### Step 4: Build the Docker Image

```bash
cd /root/pyapp
docker build -t $ECR_REPO:$IMAGE_TAG .
```

Tag the image:

```bash
docker tag $ECR_REPO:$IMAGE_TAG $IMAGE_URI
```

Verify:

```bash
docker images | grep nautilus
```

### Step 5: Push the Image to ECR

```bash
docker push $IMAGE_URI
```

Confirm image exists:

```bash
aws ecr list-images \
  --repository-name $ECR_REPO \
  --region $REGION
```

### Step 6: Create ECS Cluster (Fargate)

```bash
aws ecs create-cluster \
  --cluster-name $CLUSTER_NAME \
  --region $REGION
```

Note: Creating the cluster might take some time.

Verify:

```bash
aws ecs list-clusters --region $REGION
```

### Step 7: Create IAM Role for ECS Tasks

#### 7.1 Create Trust Policy

```bash
cat > ecs-trust-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
```

#### 7.2 Create Role

```bash
aws iam create-role \
  --role-name ecsTaskExecutionRole \
  --assume-role-policy-document file://ecs-trust-policy.json
```

#### 7.3 Attach Required Policy

```bash
aws iam attach-role-policy \
  --role-name ecsTaskExecutionRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
```

### Step 8: Register ECS Task Definition

```bash
cat > task-definition.json <<EOF
{
  "family": "$TASK_DEF_NAME",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "256",
  "memory": "512",
  "executionRoleArn": "arn:aws:iam::$ACCOUNT_ID:role/ecsTaskExecutionRole",
  "containerDefinitions": [
    {
      "name": "nautilus-container",
      "image": "$IMAGE_URI",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "protocol": "tcp"
        }
      ]
    }
  ]
}
EOF
```

Register it:

```bash
aws ecs register-task-definition \
  --cli-input-json file://task-definition.json \
  --region $REGION
```

### Step 9: Create Security Group for ECS Tasks

```bash
VPC_ID=$(aws ec2 describe-vpcs \
  --filters Name=isDefault,Values=true \
  --query "Vpcs[0].VpcId" \
  --output text)

SG_ID=$(aws ec2 create-security-group \
  --group-name nautilus-ecs-sg \
  --description "Allow HTTP traffic" \
  --vpc-id $VPC_ID \
  --query GroupId \
  --output text)
```

Allow HTTP:

```bash
aws ec2 authorize-security-group-ingress \
  --group-id $SG_ID \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0
```

### Step 10: Create ECS Service (Fargate)

```bash
SUBNETS=$(aws ec2 describe-subnets \
  --filters Name=vpc-id,Values=$VPC_ID \
  --query "Subnets[].SubnetId" \
  --output text | tr '\t' ',')

aws ecs create-service \
  --cluster $CLUSTER_NAME \
  --service-name $SERVICE_NAME \
  --task-definition $TASK_DEF_NAME \
  --desired-count 1 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[$SUBNETS],securityGroups=[$SG_ID],assignPublicIp=ENABLED}" \
  --region $REGION
```

### Step 11: Verify Deployment

```bash
aws ecs describe-services \
  --cluster $CLUSTER_NAME \
  --services $SERVICE_NAME \
  --region $REGION

aws ecs list-tasks \
  --cluster $CLUSTER_NAME \
  --region $REGION
```

You should see 1 running task.

