#!/bin/bash

ROLE_NAME=Cloud9-MyAwesomeAdmin

cat > cfn-policy.json<< EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudformation.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

## Create a temporary Admin role
aws iam create-role --role-name "$ROLE_NAME" --assume-role-policy-document file://cfn-policy.json
aws iam attach-role-policy --role-name "$ROLE_NAME" --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess"

## Wait a bit for this role to stick. It cannot be used immediately after creation.
sleep 15

## Delete stacks
stacks=(sam-app-prod sam-app-dev sam-app-pipeline aws-sam-cli-managed-prod-pipeline-resources aws-sam-cli-managed-dev-pipeline-resources)

for name in "${stacks[@]}"
do
  echo "Deleting stack: $name..."
  aws cloudformation delete-stack --role-arn "arn:aws:iam::$ACCOUNT_ID:role/$ROLE_NAME" --stack-name "$name"
  sleep 10
done

## Delete the temporary Admin role
aws iam detach-role-policy --role-name "$ROLE_NAME" --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess"
aws iam delete-role --role-name "$ROLE_NAME"
