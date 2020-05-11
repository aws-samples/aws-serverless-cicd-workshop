+++
title = "CDK prod environment"
date = 2019-11-11T14:46:02-08:00
weight = 35
draft = true
hidden = true
+++

Before we define any resources in the stack, we need to configure the CDK project to deploy this stack in the Production account. For this, the CDK has the concept of [Environments](https://docs.aws.amazon.com/cdk/latest/guide/environments.html), which allows you to deploy Stacks in different AWS accounts from within the same CDK project. 

Open the file `bin/pipeline.ts` and replace its content with the following snippet:

{{< highlight js "hl_lines=11 17" >}}
#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { PipelineStack } from '../lib/pipeline-stack';
import { ProdIAMStack } from '../lib/prod-iam-stack';

const app = new cdk.App();

new PipelineStack(app, 'sam-app-cicd', {
    env: {
        account: '0123456789', // dev account
    }
});

new ProdIAMStack(app, 'sam-app-iam-cross-account', {
    env: {
        account: '9876543210', // prod account
    }
});
{{< / highlight >}}

**NOTE**: Replace the account IDs corresponding to your dev and production AWS accounts.

{{% notice tip %}}
The command `aws sts get-caller-identity` is an easy way to get your AWS Account ID. You can also check here for other forms to find it: https://docs.aws.amazon.com/IAM/latest/UserGuide/console_account-alias.html.
{{% /notice%}}

### Test deployment

```
cd ~/environment/sam-app/pipeline
npm run build
cdk deploy sam-app-iam-cross-account --profile prod
```


