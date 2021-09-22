+++
title = "Source Stage"
date = 2021-08-30T08:30:00-06:00
weight = 15
+++

The **Source Stage** is the first step of any CI/CD pipeline and it represents your source code. This stage is in charge of triggering the pipeline based on new code changes (i.e. git push or pull requests). In this workshop, we will be using AWS CodeCommit as the source provider, but CodePipeline also supports S3, GitHub and Amazon ECR as source providers.

Append the following code snippet after your bucket definition in the **pipeline_stack.py** file:

```python
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
```

{{%expand "Click here to see how the entire file should look like" %}}

The highlighted code is the new addition: 

```python {hl_lines=["19-41"]}
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
```
{{% /expand%}}

Since we already have the CodeCommit repository, we don't need to create a new one, we just need to import it using the repository name. 

Also notice how we define an object `source_output` as a pipeline artifact; This is necessary for any files that you want CodePipeline to pass to downstream stages. In this case, we want our source code to be passed to the Build stage.

{{% notice info %}}
Don't do a `cdk deploy` just yet, because a pipeline needs to have at least 2 stages to be created. Lets continue to the next page to add a Build stage first.
{{% /notice%}}
