+++
title = "Creating a KMS Key"
date = 2019-11-11T14:46:02-08:00
weight = 30
draft = true
hidden = true
+++

The first thing we are going to do is modify the pipeline [created on Chapter 4](/buildpipe/pipeline.html), to use a symmetric Customer Master Key (CMK) to encrypt artifacts in the bucket. The easiest way to do this is by adding the following CloudFormation snippet at the end of our `pipeline.yml` file: 

```
KMSKey:
  Type: AWS::KMS::Key
  Properties:
    Description: Used to encrypt artifacts by CodePipeline
    EnableKeyRotation: true
    KeyPolicy:
      Version: "2012-10-17"
      Id: !Ref AWS::StackName
      Statement:
        -
          Effect: Allow
          Principal:
            AWS: !Sub arn:${AWS::Partition}:iam::${AWS::AccountId}:root
          Action:
            - "kms:Create*"
            - "kms:Describe*"
            - "kms:Enable*"
            - "kms:List*"
            - "kms:Put*"
            - "kms:Update*"
            - "kms:Revoke*"
            - "kms:Disable*"
            - "kms:Get*"
            - "kms:Delete*"
            - "kms:ScheduleKeyDeletion"
            - "kms:CancelKeyDeletion"
          Resource: "*"
        -
          Effect: Allow
          Principal:
            AWS:
            - !GetAtt BuildProjectRole.Arn
          Action:
            - kms:Encrypt
            - kms:Decrypt
            - kms:ReEncrypt*
            - kms:GenerateDataKey*
            - kms:DescribeKey
          Resource: "*"

KMSAlias:
  Type: AWS::KMS::Alias
  Properties:
    AliasName: !Sub alias/codepipeline-sam-app
    TargetKeyId: !Ref KMSKey
```

**(Optional)** Or if you prefer, just download the following file that already includes the snippet above.

```
wget https://cicd.serverlessworkshops.io/assets/chapter6/step1/pipeline.yml
```

### Update the pipeline using CloudFormation

Unlike previous chapters, where we were using the CloudFormation Console to launch and update stacks, this time we will update our stack using the AWS CLI as we will be doing it multiple times and is much easier to run a command than navigating a user interface over and over.

Run the following command on your terminal, it assumes that your CloudFormation stack for the pipeline is named `sam-app-cicd`. 

```
aws cloudformation deploy \
--template-file pipeline.yml \
--stack-name sam-app-cicd
```