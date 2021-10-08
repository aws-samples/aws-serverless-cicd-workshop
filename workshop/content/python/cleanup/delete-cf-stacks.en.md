+++
title = "Delete CloudFormation Stacks"
date = 2021-08-30T08:30:00-06:00
weight = 6
+++

Now that the buckets are empty, we can delete the CloudFormation stacks:

Delete the CloudFormation stacks in following sequence and please wait for each to complete before going to next one. 

Delete the **sam-app** stack

```bash
aws cloudformation delete-stack --stack-name sam-app
```

Delete the **sam-app-cicd** stack

```bash
aws cloudformation delete-stack --stack-name sam-app-cicd
```

Delete the **aws-sam-cli-managed-default** stack

```bash
aws cloudformation delete-stack --stack-name aws-sam-cli-managed-default
```

