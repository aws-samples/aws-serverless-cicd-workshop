+++
title = "Artifacts Bucket"
date = 2019-11-01T15:26:09-07:00
weight = 10
+++

Every Code Pipeline needs an artifacts bucket, also known as Artifact Store. CodePipeline will use this bucket to pass artifacts to the downstream jobs and its also where SAM will upload the artifacts during the build process. 

Let's get started and write the code for creating this bucket:

**Make sure you are editing the pipeline-stack file with _.ts_ extension**

```js
// lib/pipeline-stack.ts

import * as cdk from '@aws-cdk/core';
import s3 = require('@aws-cdk/aws-s3');
import codecommit = require('@aws-cdk/aws-codecommit');
import codepipeline = require('@aws-cdk/aws-codepipeline');
import codepipeline_actions = require('@aws-cdk/aws-codepipeline-actions');
import codebuild = require('@aws-cdk/aws-codebuild');

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

{{% notice info %}}
If you get a build error, check that all the @aws-cdk dependencies in the package.json file have the same version number, if not, fix it, delete the node_modules folder and run npm install. More info: https://github.com/aws/aws-cdk/issues/542#issuecomment-449694450.
{{% /notice %}}

The output will show that the S3 bucket got created:

![CdkBucket](/images/chapter4/screenshot-cdk-s3-bucket.png)