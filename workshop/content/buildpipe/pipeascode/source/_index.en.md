+++
title = "Source Stage"
date = 2019-11-01T15:26:09-07:00
weight = 15
+++

The **Source Stage** is the first step of any CI/CD pipeline and it represents your source code. This stage is in charge of triggering the pipeline based on new code changes (i.e. git push or pull requests). In this workshop, we will be using AWS CodeCommit as the source provider, but CodePipeline also supports S3, GitHub and Amazon ECR as source providers.

Append the following code snippet after your bucket definition in the **pipeline-stack.ts** file:

```js
// Import existing CodeCommit sam-app repository
const codeRepo = codecommit.Repository.fromRepositoryName(
  this,
  'AppRepository', // Logical name within CloudFormation
  'sam-app' // Repository name
);

// Pipeline creation starts
const pipeline = new codepipeline.Pipeline(this, 'Pipeline', {
  artifactBucket: artifactsBucket
});

// Declare source code as an artifact
const sourceOutput = new codepipeline.Artifact();

// Add source stage to pipeline
pipeline.addStage({
  stageName: 'Source',
  actions: [
    new codepipeline_actions.CodeCommitSourceAction({
      actionName: 'CodeCommit_Source',
      repository: codeRepo,
      output: sourceOutput,
    }),
  ],
});
```

{{%expand "Click here to see how the entire file should look like" %}}

The highlighted code is the new addition: 

{{< highlight js "hl_lines=16-41" >}}
// lib/pipeline-stack.ts

import * as cdk from '@aws-cdk/core';
import s3 = require('@aws-cdk/aws-s3');
import codecommit = require('@aws-cdk/aws-codecommit');
import codepipeline = require('@aws-cdk/aws-codepipeline');
import codepipeline_actions = require('@aws-cdk/aws-codepipeline-actions');

export class PipelineStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // The code that defines your stack goes here
    const artifactsBucket = new s3.Bucket(this, "ArtifactsBucket");

    // Import existing CodeCommit sam-app repository
    const codeRepo = codecommit.Repository.fromRepositoryName(
      this,
      'AppRepository', // Logical name within CloudFormation
      'sam-app' // Repository name
    );

    // Pipeline creation starts
    const pipeline = new codepipeline.Pipeline(this, 'Pipeline', {
      artifactBucket: artifactsBucket
    });

    // Declare source code as an artifact
    const sourceOutput = new codepipeline.Artifact();

    // Add source stage to pipeline
    pipeline.addStage({
      stageName: 'Source',
      actions: [
        new codepipeline_actions.CodeCommitSourceAction({
          actionName: 'CodeCommit_Source',
          repository: codeRepo,
          output: sourceOutput,
        }),
      ],
    });
  }
}
{{< / highlight >}}
{{% /expand%}}

Since we already have the CodeCommit repository, we don't need to create a new one, we just need to import it using the repository name. 

Also notice how we define an object `sourceOutput` as a pipeline artifact; This is necessary for any files that you want CodePipeline to pass to downstream stages. In this case, we want our source code to be passed to the Build stage.

{{% notice info %}}
Don't do a `cdk deploy` just yet, because a pipeline needs to have at least 2 stages to be created. Lets continue to the next page to add a Build stage first.
{{% /notice%}}
