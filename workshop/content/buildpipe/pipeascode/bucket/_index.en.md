+++
title = "Artifacts Bucket"
date = 2019-11-01T15:26:09-07:00
weight = 10
+++

Every Code Pipeline needs an artifacts bucket, also known as Artifact Store. CodePipeline will use this bucket to pass artifacts to the downstream jobs and its also where SAM will upload the artifacts during the build process. 

Let's get started and write the code for creating this bucket:

```js
// lib/pipeline-stack.ts

import * as cdk from '@aws-cdk/core';
import s3 = require('@aws-cdk/aws-s3');

export class PipelineStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // The code that defines your stack goes here
    const artifactsBucket = new s3.Bucket(this, "ArtifactsBucket");
  }
}
```

Easy right? Now build and deploy the project like you did it earlier: 

```
npm run build
cdk deploy
```

The output will show that the S3 bucket got created:

![CdkBucket](/images/chapter4/screenshot-cdk-s3-bucket.png)