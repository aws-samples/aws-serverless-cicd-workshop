+++
title = "Delete S3 Buckets"
date =  2020-07-06T18:06:08-04:00
weight = 5
+++

There are 2 buckets that got created as part of this workshop, one was created by SAM CLI and the other one was created in Chapter 4 by CodePipeline. To delete these buckets, we should empty them first and then proceed to delete them.

### First Bucket

The first bucket to cleanup is the one created by SAM CLI, you can find out the bucket name with the following command:

```bash
aws cloudformation describe-stack-resources \
--stack-name aws-sam-cli-managed-default \
| jq -r '.StackResources[] | select(.ResourceType=="AWS::S3::Bucket") | .PhysicalResourceId'
```

Empty the bucket by going to the [S3 console](https://console.aws.amazon.com/s3/home). And then Delete it.

![EmptyBucket](/images/cleanup/empty-bucket.png)

### Second Bucket

The second bucket was created by CDK to be used by CodePipeline. Let's find the bucket name with the following command:

```bash
aws cloudformation describe-stack-resources \
--stack-name sam-app-cicd \
| jq -r '.StackResources[] | select(.ResourceType=="AWS::S3::Bucket") | .PhysicalResourceId'
```

Then empty the bucket as well:

![EmptyBucket](/images/cleanup/empty-bucket-2.png)