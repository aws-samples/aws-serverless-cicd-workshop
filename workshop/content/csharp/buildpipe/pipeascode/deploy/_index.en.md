+++
title = "Deploy stage"
date = 2021-08-30T08:30:00-06:00
weight = 40
+++

The **Deploy Stage** is where your SAM application and all its resources are created an in an AWS account. The most common way to do this is by using CloudFormation changesets to deploy. This means that this stage will have two actions: the _CreateChangeSet_ and the _ExecuteChangeSet_.

Add the Deploy stage to your `PipelineStack.cs`: 

```csharp
            // Add deploy stage to pipeline
            pipeline.AddStage(new StageOptions
            {
                StageName = "Dev",
                Actions = new Action[] {
                    new CloudFormationCreateReplaceChangeSetAction(new CloudFormationCreateReplaceChangeSetActionProps
                    {
                        ActionName = "CreateChangeSet",
                        TemplatePath = new ArtifactPath_(buildOutput, "packaged.yaml"),
                        StackName = "sam-app",
                        AdminPermissions = true,
                        ChangeSetName = "sam-app-dev-changeset",
                        RunOrder = 1
                    }),
                    new CloudFormationExecuteChangeSetAction(new CloudFormationExecuteChangeSetActionProps
                    {
                        ActionName = "Deploy",
                        StackName = "sam-app",
                        ChangeSetName = "sam-app-dev-changeset",
                        RunOrder = 2
                    })
                }
            });
```

{{%expand "Click here to see how the entire file should look like" %}}

The highlighted code is the new addition: 

```csharp {hl_lines=["86-108"]}
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
            
            // Add deploy stage to pipeline
            pipeline.AddStage(new StageOptions
            {
                StageName = "Dev",
                Actions = new Action[] {
                    new CloudFormationCreateReplaceChangeSetAction(new CloudFormationCreateReplaceChangeSetActionProps
                    {
                        ActionName = "CreateChangeSet",
                        TemplatePath = new ArtifactPath_(buildOutput, "packaged.yaml"),
                        StackName = "sam-app",
                        AdminPermissions = true,
                        ChangeSetName = "sam-app-dev-changeset",
                        RunOrder = 1
                    }),
                    new CloudFormationExecuteChangeSetAction(new CloudFormationExecuteChangeSetActionProps
                    {
                        ActionName = "Deploy",
                        StackName = "sam-app",
                        ChangeSetName = "sam-app-dev-changeset",
                        RunOrder = 2
                    })
                }
            });
        }
    }
}
```
{{% /expand%}}

### Deploy the pipeline

On your terminal, run the following commands from within the `pipeline` directory:

```bash
cd ~/environment/sam-app/pipeline
cdk deploy
```

The CLI might ask you to confirm the changes before deploying, this is because we are giving Admin permissions to the IAM role that deploys our application. This is generally **not** a bad practice since this role can only be assumed by CloudFormation and not by a human, however, if your organization has a stricter security posture you may want to consider creating [a custom IAM deployment role](https://docs.aws.amazon.com/cdk/api/latest/docs/@aws-cdk_aws-iam.Role.html) with a fine grain policy. 

### Trigger a release

Navigate to your pipeline and you will see the Deploy stage has been added, however, it is currently grayed out because it hasn't been triggered. Let's just trigger a new run of the pipeline manually by clicking the **Release change** buttton. 

![ReleaseChange](/images/csharp/buildpipe/aws_console_pipeline_dev.png)