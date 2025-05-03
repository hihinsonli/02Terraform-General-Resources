# Terraform AWS Resource Group Provisioning/Destorying Repository

This repository is used to **provision** and **destroy** groups of AWS resources using Terraform.

## Resource Groups

The following AWS networking resources are included:

- [Network](resources/networks/README.md):
  - VPC
  - Subnets
  - Internet Gateway
  - NAT Gateway
  - Elastic IP
  - Route Tables
  - Network ACLs
  - VPC Endpoints


# Usage

You are provision your AWS resources on my Github repository Actions or Clone the code and provision from locall Terraforn command.

<BR>

## Option One - GitHub Actions
Please follow below steps to provision resources via GitHub Actions:

### Prerequisites
<BR>
Before proceeding, ensure you have the following:

* AWS CLI: Installed and configured with an IAM user or role that has sufficient permissions to:
  Manage IAM resources (iam:CreateOpenIDConnectProvider, iam:CreateRole, iam:PutRolePolicy, etc.).
* GitHub Repository: hihinsonli/01PROJECT-Serverless-User-API is set up and accessible.
* OpenSSL: Required to fetch the SSL certificate thumbprint.
* Please make sure you have exported AWS access token (IAM User or IAM Role) locally.

<BR>

## Bootstrap Steps - Run on your local machine.

<BR>

Step 1: Retrieve the SHA-1 Fingerprint (Thumbprint) of GitHub's OIDC SSL Certificate
Run the following command to fetch the SHA-1 fingerprint (thumbprint) of GitHub's OIDC provider SSL certificate (token.actions.githubusercontent.com) in the correct format for AWS:
`echo | openssl s_client -servername token.actions.githubusercontent.com -showcerts -connect token.actions.githubusercontent.com:443 2>/dev/null | openssl x509 -fingerprint -noout | sed 's/SHA1 Fingerprint=//' | tr -d ':'`

Expected Output: A 40-character hexadecimal string.

<BR>

Step 2: Create the OIDC Provider in AWS
Using the thumbprint retrieved in Step 1, create an OIDC provider in AWS to allow GitHub Actions to authenticate via OIDC:
```
aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list <40-character hexadecimal string from step 1>
```

Expected Output:
```
{
    "OpenIDConnectProviderArn": "arn:aws:iam::<your_account>:oidc-provider/token.actions.githubusercontent.com"
}
```

<BR>

Step 3: Verify the OIDC Provider
Verify that the OIDC provider was created successfully:
`aws iam list-open-id-connect-providers`

Expected Output:
```
{
    "OpenIDConnectProviderList": [
        {
            "Arn": "arn:aws:iam::<your_account>:oidc-provider/token.actions.githubusercontent.com"
        }
    ]
}
```
<BR>

<BR>

Step 4: Create Terraform state S3 bucket
Run the shell script(/shell/)terraform-state-bucket.sh:

```
cd 02Terraform-General-Resources/shell
./terraform-state-bucket.sh
```
Follow the prompt instruction to create the bucket.

<BR>

<BR>

Step 5: Create DynamoDB Table for State Locking
Run below commands to create DynamoDB Table:

```
# Variables
export TABLE_NAME="my-web-app-terraform-locks"
export AWS_REGION="ap-southeast-2"

# Create the DynamoDB table
aws dynamodb create-table \
  --table-name $TABLE_NAME \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --region $AWS_REGION
```

<BR>

<BR>

Step 6: Create the Trust Policy Document
Run command below on your local machine, make sure your local machine has been granted by AWS access token.
```
cat << EOF > github-actions-trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<your_account>:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:hihinsonli/02Terraform-General-Resources:*"
        }
      }
    }
  ]
}
EOF
```

<BR>

<BR>

Step 7: Create a file named github-actions-policy.json
Run below command on your local machine:

<b> Please make sure you have replaced below in the policy document. </b>
  - <your_terraform_state_bucket_created_in_step_4>
  - <your_dynamo_db_table_created_in_step_5>
  - <your_account>

```
cat << EOF > github-actions-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateVpc",
        "ec2:ModifyVpcAttribute",
        "ec2:DeleteVpc",
        "ec2:DescribeVpcs",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateSubnet",
        "ec2:ModifySubnetAttribute",
        "ec2:DeleteSubnet",
        "ec2:DescribeSubnets",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateRouteTable",
        "ec2:CreateRoute",
        "ec2:DeleteRouteTable",
        "ec2:DeleteRoute",
        "ec2:AssociateRouteTable",
        "ec2:DisassociateRouteTable",
        "ec2:DescribeRouteTables",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateInternetGateway",
        "ec2:AttachInternetGateway",
        "ec2:DetachInternetGateway",
        "ec2:DeleteInternetGateway",
        "ec2:DescribeInternetGateways",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AllocateAddress",
        "ec2:ReleaseAddress",
        "ec2:DescribeAddresses",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNatGateway",
        "ec2:DeleteNatGateway",
        "ec2:DescribeNatGateways",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkAcl",
        "ec2:CreateNetworkAclEntry",
        "ec2:DeleteNetworkAcl",
        "ec2:DeleteNetworkAclEntry",
        "ec2:ReplaceNetworkAclAssociation",
        "ec2:DescribeNetworkAcls",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeRegions",
        "ec2:DescribeAccountAttributes"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::<your_terraform_state_bucket_created_in_step_4>",
        "arn:aws:s3:::<your_terraform_state_bucket_created_in_step_4>/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "arn:aws:dynamodb:ap-southeast-2:<your_account>:table/<your_dynamo_db_table_created_in_step_5>"
    }
  ]
}
EOF
```

<BR>

<BR>

Step 8: Create the Policy
Run below command on your local machine:
```
aws iam create-policy \
  --policy-name GitHubActionsPolicy \
  --policy-document file://github-actions-policy.json
```

<BR>

<BR>

Step 9: Create the `GitHubActionsRole` Role
Run below command on your local machine:

```
aws iam create-role \
  --role-name GitHubActionsRole \
  --assume-role-policy-document file://github-actions-trust-policy.json
```

<BR>

<BR>

Step 10: Attach the Policy to the Role
Run below command on your local machine:

```
aws iam attach-role-policy \
  --role-name GitHubActionsRole \
  --policy-arn arn:aws:iam::<your_account>:policy/GitHubActionsPolicy
```

<BR>

<BR>

Step 11: Update Terraform Code (version.tf) to Use S3 Backend and DynamoDB Lock Table

```
terraform {
  # Terraform version constraint: https://www.terraform.io/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.2.7, < 2.0.0"

  # Providers & version:
  required_providers {
    # AWS provider & version constraint: https://registry.terraform.io/providers/hashicorp/aws/latest
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.93.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }

  backend "s3" {
    bucket         = "<your_terraform_state_bucket_created_in_step_4>"
    key            = "<resource_prefix_you_name_it>/terraform.tfstate"
    region         = "<your_region>"
    dynamodb_table = "<your_dynamo_db_table_created_in_step_5>"
  }
}
```

## Deployment - Trigger Github Actions workflow manually
