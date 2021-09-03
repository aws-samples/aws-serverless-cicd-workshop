+++
title = "Artifacts Bucket"
date = 2021-08-30T08:30:00-06:00
weight = 10
+++

Every CodePipeline needs an artifacts bucket, also known as Artifact Store. CodePipeline will use this bucket to pass artifacts to the downstream jobs and its also where SAM will upload the artifacts during the build process. 

Let's get started and write the code for creating this bucket:

```csharp
// pipeline/src/PipelineStack.cs

using Amazon.CDK;
using Amazon.CDK.AWS.CodeBuild;
using Amazon.CDK.AWS.CodeCommit;
using Amazon.CDK.AWS.CodePipeline;
using Action = Amazon.CDK.AWS.CodePipeline.Action;
using Amazon.CDK.AWS.CodePipeline.Actions;
using Amazon.CDK.AWS.S3;
using System.Collections.Generic;

namespace Pipeline
{
    public class PipelineStack : Stack
    {
        internal PipelineStack(Construct scope, string id, IStackProps props = null) : base(scope, id, props)
        {
            // The code that defines your stack goes here
            var artifactsBucket = new Bucket(this, "ArtifactsBucket");
        }
    }
}

```

Easy right? Now build and deploy the project like you did it earlier: 

```bash
cdk deploy
```


The output will show that a S3 bucket is being created:
