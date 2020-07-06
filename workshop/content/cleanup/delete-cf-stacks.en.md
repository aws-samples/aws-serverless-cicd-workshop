+++
title = "Delete CF Stacks"
date =  2020-07-06T18:10:22-04:00
weight = 6
+++

In order to delete the resources created we need to delete the Cloudformation stacks:

Delete the CF stacks

```
aws cloudformation delete-stack --stack-name aws-sam-cli-managed-default
aws cloudformation delete-stack --stack-name sam-app
aws cloudformation delete-stack --stack-name sam-app-cicd

```

