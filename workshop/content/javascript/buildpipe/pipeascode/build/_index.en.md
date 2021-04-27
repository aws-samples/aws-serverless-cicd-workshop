+++
title = "Build Stage"
date = 2019-11-01T15:26:09-07:00
weight = 20
+++

The **Build Stage** is where your Serverless application gets built and packaged by SAM. We are going to use AWS CodeBuild as the Build provider for our pipeline. It is worth mentioning that CodePipeline also supports other providers like Jenkins, TeamCity or CloudBees. 

### Why AWS Code Build?

AWS CodeBuild is a great option because you only pay for the time where your build is running, which makes it very cost effective compared to running a dedicated build server 24 hours a day when you really only build during office hours. It is also container-based which means that you can bring your own Docker container image where your build runs, or [use a managed image](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html) provided by CodeBuild.  

### Add the build stage

Let's go ahead and add a Build stage to you pipeline-stack.ts:

```js
// Declare build output as artifacts
const buildOutput = new codepipeline.Artifact();

// Declare a new CodeBuild project
const buildProject = new codebuild.PipelineProject(this, 'Build', {
  environment: { buildImage: codebuild.LinuxBuildImage.AMAZON_LINUX_2_2 },
  environmentVariables: {
    'PACKAGE_BUCKET': {
      value: artifactsBucket.bucketName
    }
  }
});

// Add the build stage to our pipeline
pipeline.addStage({
  stageName: 'Build',
  actions: [
    new codepipeline_actions.CodeBuildAction({
      actionName: 'Build',
      project: buildProject,
      input: sourceOutput,
      outputs: [buildOutput],
    }),
  ],
});
```

{{%expand "Click here to see how the entire file should look like" %}}

The highlighted code is the new addition: 

```js {hl_lines=["44-68"]}
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
    
    // Declare build output as artifacts
    const buildOutput = new codepipeline.Artifact();
    
    // Declare a new CodeBuild project
    const buildProject = new codebuild.PipelineProject(this, 'Build', {
      environment: { buildImage: codebuild.LinuxBuildImage.AMAZON_LINUX_2_2 },
      environmentVariables: {
        'PACKAGE_BUCKET': {
          value: artifactsBucket.bucketName
        }
      }
    });
    
    // Add the build stage to our pipeline
    pipeline.addStage({
      stageName: 'Build',
      actions: [
        new codepipeline_actions.CodeBuildAction({
          actionName: 'Build',
          project: buildProject,
          input: sourceOutput,
          outputs: [buildOutput],
        }),
      ],
    });
    
  }
}
```
{{% /expand%}}

### Deploy the pipeline

From your terminal, run the following commands to deploy the pipeline:

```
npm run build
cdk deploy
```

### Verify pipeline creation

Navigate to the [AWS CodePipeline Console](https://console.aws.amazon.com/codesuite/codepipeline/home) and click on your newly created pipeline! 

![VerifyPipeline](/images/chapter4/screenshot-pipeline-verify-1.png)

The Build step should have failed. **Don't worry! this is expected** because we haven't specified what commands to run during the build yet, so AWS CodeBuild doesn't know how to build our Serverless application.

![VerifyPipeline](/images/chapter4/screenshot-pipeline-verify-2.png)

Let's fix that.