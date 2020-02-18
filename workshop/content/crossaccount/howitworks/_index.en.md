+++
title = "How does it work"
date = 2019-11-11T14:46:02-08:00
weight = 20
+++

Before jumping to the implementation, we need to understand the different pieces that allow Code Pipeline to deploy across a different account. The following diagram shows a zoomed-in view of the services and roles involved in this process. 

![CrossAccountDeploy](/images/cross-account-deploy.png)

#### Explanation

The diagram above illustrates what happens when CodePipeline begins a deployment to the Production account. The first step is to assume the **IAM Pipeline Role** that exists in the Production account; This is possible because the role has a Trust Policy that allows the Development account to assume it. The second step is CodePipeline uses that role to trigger a deployment in CloudFormation by passing the **IAM Deployer Role**. This action is called [PassRole](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html) and is needed for CloudFormation to create resources on your behalf. Finally, as you learned in previous chapters, CloudFormation gets the deployment artifacts from S3 and decrypts them by using the KMS Customer Managed Key. 

#### Why encrypt the artifacts?

AWS CodePipeline *always* stores artifacts on S3 with encryption enabled and there is no way to disable it. The default behavior is to use the AWS Managed Key to encrypt them, but this approach doesn't work for granting access to S3 buckets across accounts. Therefore you must create a KMS Customer Managed Key and then give the IAM role in the Production account permissions to use it to decrypt the artifacts. 