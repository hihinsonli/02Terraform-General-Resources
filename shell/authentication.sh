#!/bin/bash

#########################################################################################################
# Script to authenticate via AWS IAM user using MFA for local testing (not for GitHub Actions automation)
#########################################################################################################

# Prompt for required input
echo "Accept user input for setting up aws session credential:"
echo -n "AWS Account No: "
read aws_account_no
echo -n "AWS IAM User: "
read aws_iam_user
echo -n "AWS Profile: "
read aws_profile
echo -n "MFA Token Code: "
read mfa_token_code

# Build MFA device ARN
mfa_serial="arn:aws:iam::${aws_account_no}:mfa/${aws_iam_user}"

# Clear old credentials
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

# Request temporary session credentials
session=$(aws sts get-session-token \
  --profile "$aws_profile" \
  --serial-number "$mfa_serial" \
  --token-code "$mfa_token_code" \
  --query "Credentials" \
  --output json)

# Exit on failure
if [ $? -ne 0 ]; then
  echo "❌ Failed to get session token. Please check your MFA code and try again."
  exit 1
fi

# Export credentials
export AWS_ACCESS_KEY_ID=$(echo "$session" | jq -r .AccessKeyId)
export AWS_SECRET_ACCESS_KEY=$(echo "$session" | jq -r .SecretAccessKey)
export AWS_SESSION_TOKEN=$(echo "$session" | jq -r .SessionToken)

echo "✅ AWS session credentials set."
