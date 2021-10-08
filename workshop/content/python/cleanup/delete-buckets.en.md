+++
title = "Delete S3 Buckets"
date = 2021-08-30T08:30:00-06:00
weight = 5
+++

There are two buckets that got created as part of this workshop, one was created by SAM CLI and the other one was created in [Chapter 4](/python/buildpipe/bucket.html) by CodePipeline. To delete these buckets, we should empty them first and then proceed to delete them.

### First Bucket

The first bucket to cleanup is the one created by SAM CLI, you can find out the bucket name with the following command:

```bash
aws cloudformation describe-stack-resources \
--stack-name aws-sam-cli-managed-default \
--query "StackResources[?ResourceType == 'AWS::S3::Bucket'].PhysicalResourceId" --output text
```

Go to the [S3 console](https://console.aws.amazon.com/s3/home) and find the bucket by entering `aws-sam-cli` in to the search field.  Select the radio button and click the **Empty** button.  After the confirmation flow, click the **Delete** button.

![EmptyBucket](/images/python/cleanup/s3_bucket_sam_cli.png)

### Second Bucket

The second bucket was created by CDK to be used by CodePipeline. Let's find the bucket name with the following command:

```bash
aws cloudformation describe-stack-resources \
--stack-name sam-app-cicd \
--query "StackResources[?ResourceType == 'AWS::S3::Bucket'].PhysicalResourceId" --output text
```

This time find the bucket by entering `sam-app` in to the search field.  **Empty** and **Delete** this bucket as well:

![EmptyBucket](/images/python/cleanup/s3_bucket_sam_app.png)