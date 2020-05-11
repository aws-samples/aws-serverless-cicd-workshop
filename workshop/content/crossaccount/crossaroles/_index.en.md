+++
title = "Cross account roles"
date = 2019-11-11T14:46:02-08:00
weight = 40
draft = true
hidden = true
+++

Now that we have verified that we can deploy an empty stack to production, lets create the actual cross account roles in the `lib/prod-iam-stack.ts` file we created earlier. Add the following content to the file:

{{< highlight js "hl_lines=26" >}}
import * as cdk from '@aws-cdk/core';
import iam = require('@aws-cdk/aws-iam');

export class ProdIAMStack extends cdk.Stack {
    constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
      super(scope, id, props);

      /**
       * IAM Deployer Role. Will be used to deploy 
       * the serverless app. Needs admin permissions.
       */
      const deployerRole = new iam.Role(this, 'DeployerRole', {
        assumedBy: new iam.ServicePrincipal('cloudformation.amazonaws.com')
      });

      deployerRole.addManagedPolicy(
          iam.ManagedPolicy.fromAwsManagedPolicyName("AdministratorAccess")
      );

      /**
       * IAM Cross Account Access Role. Will be assumed by
       * the CodePipeline in the dev account, needs permissions
       * to pass the Deployer role defined above.
       */
      const crossAccountRole = new iam.Role(this, 'CrossAccountRole', {
          assumedBy: new iam.AccountPrincipal("REPLACE ME"), // replace with dev account id
      });

      // Needs CloudFormation permissions
      crossAccountRole.addManagedPolicy(
          iam.ManagedPolicy.fromAwsManagedPolicyName("AWSCloudFormationFullAccess")
      );

      // Needs permissions to pass the deployer role defined above
      crossAccountRole.addToPolicy(new iam.PolicyStatement({
          actions: ['iam:PassRole'],
          resources: [deployerRole.roleArn]
      }));

      // Needs S3 permissions to access artifacts in the DEV account
      crossAccountRole.addToPolicy(new iam.PolicyStatement({
          actions: ['s3:GetObject'],
          resources: ['*']
      }));

      // Needs KMS permissions to decrypt objects in the DEV account
      crossAccountRole.addToPolicy(new iam.PolicyStatement({
          actions: ['kms:Decrypt'],
          resources: ['*']
      }));

      /**
       * Outputs
       */
      new cdk.CfnOutput(this, 'ProdCrossAccountRoleArn', {
          value: crossAccountRole.roleArn,
      });

      new cdk.CfnOutput(this, 'DeployerRoleArn', {
        value: deployerRole.roleArn,
      });

    }
}
{{< / highlight >}}

**NOTE:** Replace the highlighted line with the corresponding DEV account id.

### Deploy stack

```
npm run build
cdk deploy sam-app-iam-cross-account --profile prod
```
