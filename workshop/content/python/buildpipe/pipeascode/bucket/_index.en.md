+++
title = "Artifacts Bucket"
date = 2021-08-30T08:30:00-06:00
weight = 10
+++

Every CodePipeline needs an artifacts bucket, also known as Artifact Store. CodePipeline will use this bucket to pass artifacts to the downstream jobs and its also where SAM will upload the artifacts during the build process. 

Let's get started and write the code for creating this bucket:

```python
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
```

Easy right? Now build and deploy the project like you did it earlier: 

```bash
cdk deploy
```


The output will show that a S3 bucket is being created:
