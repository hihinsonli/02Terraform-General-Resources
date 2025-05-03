#!/bin/bash

# Prompt for AWS Region with default
echo -n "Enter AWS region [default: ap-southeast-2]: "
read AWS_REGION
AWS_REGION=${AWS_REGION:-ap-southeast-2}

# Prompt for S3 Bucket Name with default
echo -n "Enter S3 bucket name [default: my-web-app-terraform-state-123456]: "
read BUCKET_NAME
BUCKET_NAME=${BUCKET_NAME:-my-web-app-terraform-state-123456}

echo "Creating S3 bucket '$BUCKET_NAME' in region '$AWS_REGION'..."

# Create the S3 bucket
aws s3api create-bucket \
  --bucket "$BUCKET_NAME" \
  --region "$AWS_REGION" \
  --create-bucket-configuration LocationConstraint="$AWS_REGION"

# Enable versioning on the bucket
aws s3api put-bucket-versioning \
  --bucket "$BUCKET_NAME" \
  --versioning-configuration Status=Enabled

# Enable server-side encryption
aws s3api put-bucket-encryption \
  --bucket "$BUCKET_NAME" \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }]
  }'

# Block public access
aws s3api put-public-access-block \
  --bucket "$BUCKET_NAME" \
  --public-access-block-configuration '{
    "BlockPublicAcls": true,
    "IgnorePublicAcls": true,
    "BlockPublicPolicy": true,
    "RestrictPublicBuckets": true
  }'

echo "S3 bucket '$BUCKET_NAME' has been configured successfully."
