+++
title = "Build Stage"
date = 2021-08-30T08:30:00-06:00
weight = 20
+++

The **Build Stage** is where your Serverless application gets built and packaged by SAM. We are going to use AWS CodeBuild as the Build provider for our pipeline. It is worth mentioning that CodePipeline also supports other providers like Jenkins, TeamCity, or CloudBees. 

### Why AWS CodeBuild?

AWS CodeBuild is a great option because you only pay for the time where your build is running, which makes it very cost effective compared to running a dedicated build server 24 hours a day when you really only build during office hours. It is also container-based which means that you can bring your own Docker container image where your build runs, or [use a managed image](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html) provided by CodeBuild.  

### Add the build stage

Let's go ahead and add a Build stage to your `pipeline_stack.py`:

```python
        # Declare build output as artifacts
        build_output = codepipeline.Artifact()
        
        # Declare a new CodeBuild project
        build_project = codebuild.PipelineProject(self, "Build", 
            environment = codebuild.BuildEnvironment(
                build_image = codebuild.LinuxBuildImage.STANDARD_5_0,
            ),
            environment_variables = {
                'PACKAGE_BUCKET': codebuild.BuildEnvironmentVariable(value = artifacts_bucket.bucket_name),
            },
        )
        
        # Add the build stage to our pipeline
        pipeline.add_stage(
            stage_name = "Build", 
            actions = [
                codepipeline_actions.CodeBuildAction(
                    action_name = "Build",
                    project = build_project,
                    input = source_output,
                    outputs = [build_output],
                )
            ]
        )
```

{{%expand "Click here to see how the entire file should look like" %}}

The highlighted code is the new addition: 

```python {hl_lines=["43-68"]}
# pipeline/pipeline_stack.py

from aws_cdk import (core as cdk,
                     aws_s3 as s3,
                     aws_codebuild as codebuild,
                     aws_codecommit as codecommit,
                     aws_codepipeline as codepipeline,
                     aws_codepipeline_actions as codepipeline_actions)


class PipelineStack(cdk.Stack):

    def __init__(self, scope: cdk.Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # The code that defines your stack goes here
        artifacts_bucket = s3.Bucket(self, "ArtifactsBucket")
        
        # Import existing CodeCommit sam-app repository
        code_repo = codecommit.Repository.from_repository_name(self, "AppRepository", "sam-app")
        
        # Pipeline creation starts
        pipeline = codepipeline.Pipeline(self, "Pipeline",
          artifact_bucket = artifacts_bucket
        )
        
        # Declare source code as an artifact
        source_output = codepipeline.Artifact()
        
        # Add source stage to pipeline
        pipeline.add_stage(
            stage_name = "Source", 
            actions = [ 
                codepipeline_actions.CodeCommitSourceAction(
                    action_name = "Source",
                    branch = "main",
                    output = source_output,
                    repository = code_repo,
                )
            ]
        )
        
        # Declare build output as artifacts
        build_output = codepipeline.Artifact()
        
        # Declare a new CodeBuild project
        build_project = codebuild.PipelineProject(self, "Build", 
            environment = codebuild.BuildEnvironment(
                build_image = codebuild.LinuxBuildImage.STANDARD_5_0,
            ),
            environment_variables = {
                'PACKAGE_BUCKET': codebuild.BuildEnvironmentVariable(value = artifacts_bucket.bucket_name),
            },
        )
        
        # Add the build stage to our pipeline
        pipeline.add_stage(
            stage_name = "Build", 
            actions = [
                codepipeline_actions.CodeBuildAction(
                    action_name = "Build",
                    project = build_project,
                    input = source_output,
                    outputs = [build_output],
                )
            ]
        )
```
{{% /expand%}}

### Deploy the pipeline

From your terminal, run the following command to deploy the pipeline and confirm the "Do you wish to deploy these changes (y/n)?" prompt by selecting `y`.

```bash
cdk deploy
```

### Verify pipeline creation

Navigate to the [AWS CodePipeline Console](https://console.aws.amazon.com/codesuite/codepipeline/home) and click on your newly created pipeline!

![VerifyPipeline](/images/python/buildpipe/aws_console_pipeline_failed.png) 

The execution should have failed. **Don't worry! this is expected** because we haven't specified what commands to run during the build yet, so AWS CodeBuild doesn't know how to build our Serverless application.

Let's fix that.