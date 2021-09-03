+++
title = "Build Stage"
date = 2021-08-30T08:30:00-06:00
weight = 20
+++

The **Build Stage** is where your Serverless application gets built and packaged by SAM. We are going to use AWS CodeBuild as the Build provider for our pipeline. It is worth mentioning that CodePipeline also supports other providers like Jenkins, TeamCity, or CloudBees. 

### Why AWS CodeBuild?

AWS CodeBuild is a great option because you only pay for the time where your build is running, which makes it very cost effective compared to running a dedicated build server 24 hours a day when you really only build during office hours. It is also container-based which means that you can bring your own Docker container image where your build runs, or [use a managed image](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html) provided by CodeBuild.  

### Add the build stage

Let's go ahead and add a Build stage to your `PipelineStack.cs`:

```csharp
            // Declare build output as artifacts
            var buildOutput = new Artifact_();
        
            // Declare a new CodeBuild project
            var buildProject = new Project(this, "Build", new ProjectProps
            {
                Environment = new BuildEnvironment
                {
                    BuildImage = LinuxBuildImage.STANDARD_5_0
                },
                EnvironmentVariables = new Dictionary<string, IBuildEnvironmentVariable>
                {
                    ["PACKAGE_BUCKET"] = new BuildEnvironmentVariable {
                        Value = artifactsBucket.BucketName,
                        Type = BuildEnvironmentVariableType.PLAINTEXT
                    }
                },
                Source = Source.CodeCommit(new CodeCommitSourceProps
                {
                    Repository = codeRepo
                })
            });
            
            // Add the build stage to our pipeline
            pipeline.AddStage(new StageOptions
            {
                StageName = "Build",
                Actions = new Action[] {
                    new CodeBuildAction(new CodeBuildActionProps
                    {
                        ActionName = "Build",
                        Project = buildProject,
                        Input = sourceOutput,
                        Outputs = new Artifact_[] { buildOutput }
                    })
                }
            });
```

{{%expand "Click here to see how the entire file should look like" %}}

The highlighted code is the new addition: 

```csharp {hl_lines=["48-84"]}
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

            // Declare build output as artifacts
            var buildOutput = new Artifact_();
        
            // Declare a new CodeBuild project
            var buildProject = new Project(this, "Build", new ProjectProps
            {
                Environment = new BuildEnvironment
                {
                    BuildImage = LinuxBuildImage.STANDARD_5_0
                },
                EnvironmentVariables = new Dictionary<string, IBuildEnvironmentVariable>
                {
                    ["PACKAGE_BUCKET"] = new BuildEnvironmentVariable {
                        Value = artifactsBucket.BucketName,
                        Type = BuildEnvironmentVariableType.PLAINTEXT
                    }
                },
                Source = Source.CodeCommit(new CodeCommitSourceProps
                {
                    Repository = codeRepo
                })
            });
            
            // Add the build stage to our pipeline
            pipeline.AddStage(new StageOptions
            {
                StageName = "Build",
                Actions = new Action[] {
                    new CodeBuildAction(new CodeBuildActionProps
                    {
                        ActionName = "Build",
                        Project = buildProject,
                        Input = sourceOutput,
                        Outputs = new Artifact_[] { buildOutput }
                    })
                }
            });
        }
    }
}
```
{{% /expand%}}

### Deploy the pipeline

From your terminal, run the following command to deploy the pipeline and confirm the "Do you wish to deploy these changes (y/n)?" prompt by selecting `y`.

```bash
cdk deploy
```

### Verify pipeline creation

Navigate to the [AWS CodePipeline Console](https://console.aws.amazon.com/codesuite/codepipeline/home) and click on your newly created pipeline!

![VerifyPipeline](/images/csharp/buildpipe/aws_console_pipeline_failed.png) 

The execution should have failed. **Don't worry! this is expected** because we haven't specified what commands to run during the build yet, so AWS CodeBuild doesn't know how to build our Serverless application.

Let's fix that.