+++
title = "Verify pipeline"
date = 2019-11-05T14:20:52-08:00
weight = 35
+++

### Deploy the pipeline

Now that our CodePipeline and CodeBuild configuration files are checked into our Git repository,
we will kick off another CloudFormation build for those CI/CD resources. Note, you only need to do this
*one* time.

```shell
sam deploy -t codepipeline.yaml --stack-name sam-app-pipeline --capabilities=CAPABILITY_IAM
```

{{% notice info %}}
This is going to take a few minutes to complete. You can track the progress by going to the
CloudFormation console and looking at the status of the `sam-app-pipeline` stack.
{{% /notice %}}

Once the `sam-app-pipeline` CloudFormation stack has completed, you will have a new CodePipeline.
Navigate to the [CodePipeline Console](https://console.aws.amazon.com/codesuite/codepipeline/pipelines).
You should see a single Pipeline.

Let your pipline run every stage. After it finishes it will look all green like the following screenshot:

![VerifyPipelineRunning](/images/chapter4-pipelines/screenshot-pipeline-verify-3.png)

**TODO - Add some more explanation here about what happened and how the Pipeline actually builds multiple CFN stacks**

**TODO - Add an example of enabling unit tests. Talk about how the Pipeline is self-updating.**
#### Congratulations! You have created a CI/CD pipeline for a Serverless application!
