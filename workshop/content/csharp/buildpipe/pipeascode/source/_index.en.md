+++
title = "Source Stage"
date = 2021-08-30T08:30:00-06:00
weight = 15
+++

The **Source Stage** is the first step of any CI/CD pipeline and it represents your source code. This stage is in charge of triggering the pipeline based on new code changes (i.e. git push or pull requests). In this workshop, we will be using AWS CodeCommit as the source provider, but CodePipeline also supports S3, GitHub and Amazon ECR as source providers.

Append the following code snippet after your bucket definition in the **PipelineStack.cs** file:

```csharp
            // Import existing CodeCommit sam-app repository
            var codeRepo = Repository.FromRepositoryName(this, "AppRepository", "sam-app");
        
            // Pipeline creation starts
            var pipeline = new Amazon.CDK.AWS.CodePipeline.Pipeline(this, "Pipeline", new PipelineProps
            {
                ArtifactBucket = artifactsBucket
            });
        
            // Declare source code as an artifact
            var sourceOutput = new Artifact_();
        
            // Add source stage to pipeline
            pipeline.AddStage(new StageOptions
            {
                StageName = "Source",
                Actions = new Action[] {
                    new CodeCommitSourceAction(new CodeCommitSourceActionProps
                    {
                        ActionName = "Source",
                        Branch = "main",
                        Output = sourceOutput,
                        Repository = codeRepo
                    })
                }
            });  
```

{{%expand "Click here to see how the entire file should look like" %}}

The highlighted code is the new addition: 

```csharp {hl_lines=["21-46"]}
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
            
            // Import existing CodeCommit sam-app repository
            var codeRepo = Repository.FromRepositoryName(this, "AppRepository", "sam-app");
        
            // Pipeline creation starts
            var pipeline = new Amazon.CDK.AWS.CodePipeline.Pipeline(this, "Pipeline", new PipelineProps
            {
                ArtifactBucket = artifactsBucket
            });
        
            // Declare source code as an artifact
            var sourceOutput = new Artifact_();
        
            // Add source stage to pipeline
            pipeline.AddStage(new StageOptions
            {
                StageName = "Source",
                Actions = new Action[] {
                    new CodeCommitSourceAction(new CodeCommitSourceActionProps
                    {
                        ActionName = "Source",
                        Branch = "main",
                        Output = sourceOutput,
                        Repository = codeRepo
                    })
                }
            });
        }
    }
}

```
{{% /expand%}}

Since we already have the CodeCommit repository, we don't need to create a new one, we just need to import it using the repository name. 

Also notice how we define an object `sourceOutput` as a pipeline artifact; This is necessary for any files that you want CodePipeline to pass to downstream stages. In this case, we want our source code to be passed to the Build stage.

{{% notice info %}}
Don't do a `cdk deploy` just yet, because a pipeline needs to have at least 2 stages to be created. Lets continue to the next page to add a Build stage first.
{{% /notice%}}
