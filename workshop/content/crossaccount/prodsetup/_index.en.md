+++
title = "Prod account setup"
date = 2019-11-11T14:46:02-08:00
weight = 30
draft = true
hidden = true
+++

Let's get started creating the necessary IAM roles in the Production account to grant cross account access. We will do this as a separate stack within the same CDK project created in Chapter 4.

Run the following command to create a new file named _prod-iam-stack.ts_ inside the _lib_ drectory. 

```
cd ~/environment/sam-app/pipeline
touch lib/prod-iam-stack.ts
```

Paste to following content inside the file: 

```js
import * as cdk from '@aws-cdk/core';
import iam = require('@aws-cdk/aws-iam');

export class ProdIAMStack extends cdk.Stack {
    constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
      super(scope, id, props);

      // Resource definition goes here
    }
}
```

It should look like this: 

![NewIamProdStack](/images/chapter6/new-file-prod-stack.png)

