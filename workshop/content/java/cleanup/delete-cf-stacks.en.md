+++
title = "Delete CF Stacks"
date =  2020-07-06T18:10:22-04:00
weight = 6
+++

Now that the buckets are empty, we can delete the Cloudformation stacks:

Delete the CF stacks in following sequence and please wait for each to complete before going to next one. 

Delete **sam-app**
```
aws cloudformation delete-stack --stack-name sam-app
```

Delete **sam-app-cicd**
```
aws cloudformation delete-stack --stack-name sam-app-cicd
```

Delete **aws-sam-cli-managed-default**

```
aws cloudformation delete-stack --stack-name aws-sam-cli-managed-default

```

