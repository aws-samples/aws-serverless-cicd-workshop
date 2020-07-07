+++
title = "Delete Buckets"
date =  2020-07-06T18:06:08-04:00
weight = 5
+++

To delete the resources created by the applications, we should empty the S3 buckets and then delete the buckets.

Note that if you followed the cleanup section of the modules, some of the commands below might fail because there is nothing to delete and its ok.

Delete the Buckets:


**First Bucket**
```
STACK_NAME=aws-sam-cli-managed-default
BUCKET_NAME=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME | jq -r '.StackResources[] | select(.ResourceType=="AWS::S3::Bucket") | .PhysicalResourceId')
aws s3api list-object-versions --bucket $BUCKET_NAME --query 'Versions[].[Key, VersionId]' | jq -r '.[] | "--key '\''" + .[0] + "'\'' --version-id " + .[1]' |  xargs -L1 aws s3api delete-object --bucket $BUCKET_NAME
aws s3 rb s3://$BUCKET_NAME/ --force

```
**Second Bucket**
```

STACK_NAME=sam-app-cicd
BUCKET_NAME=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME | jq -r '.StackResources[] | select(.ResourceType=="AWS::S3::Bucket") | .PhysicalResourceId')
aws s3 rb s3://$BUCKET_NAME/ --force

```