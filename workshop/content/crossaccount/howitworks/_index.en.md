+++
title = "How it works"
date = 2019-11-11T14:46:02-08:00
weight = 20
draft = true
hidden = true
+++

Before jumping to the implementation, we need to understand the different pieces that allow Code Pipeline to deploy across a different account. The following diagram shows a zoomed-in view of the services and roles involved in this process. 

![CrossAccountDeploy](/images/chapter6/cross-account-deploy.png)

#### Explanation

The diagram above illustrates what happens when CodePipeline begins a deployment to the Production account. The first step is to assume the **IAM Cross Account Role** that exists in the Production account; This is possible because the role has a Trust Policy that allows the Dev account to assume it. The second step is CodePipeline uses that role to trigger a deployment in CloudFormation by passing the **IAM Deployer Role**. This action is called [PassRole](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html) and is needed for CloudFormation to create resources on your behalf. Finally, as you learned in previous chapters, CloudFormation gets the deployment artifacts from S3 and decrypts them by using the KMS Customer Managed Key. 

#### Why encrypt the artifacts?

AWS CodePipeline *always* stores artifacts on S3 with encryption-at-rest enabled and there is no way to disable it. The default behavior is to use the AWS Managed Key to encrypt them, but this approach doesn't work for granting access to S3 buckets across accounts. Therefore you [3] must create a KMS Customer Master Key and then give the IAM role in the Production account permissions to use it to decrypt the artifacts. 

#### Additional reading

If you want to dive deeper into the concepts of Cross Account permissions in regards to Code Pipeline, here are a couple of good reads that might help you understand it better: 

[1] [Building a Secure Cross Account Pipeline](https://aws.amazon.com/blogs/devops/aws-building-a-secure-cross-account-continuous-delivery-pipeline)  
[2] [AWS Code Pipeline Cross Account Docs](https://docs.aws.amazon.com/codepipeline/latest/userguide/pipelines-create-cross-account.html)  
[3] [Cross Account Permissions with S3 Buckets](https://aws.amazon.com/premiumsupport/knowledge-center/cross-account-access-denied-error-s3)  