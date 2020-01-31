+++
title = "Launch template"
date = 2020-01-03T19:29:29-08:00
weight = 5
+++

Open the [AWS CloudFormation console]((https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=sam-app-ci-cd)) to launch a new stack and upload the downloaded template by choosing the _Upload a template_ file option.

![PipelineConfiguration](/images/screenshot-pipeline-cfn-1.png)

The `CodeCommitRepoName` parameter is pre-populated with `sam-app`. If you named your CodeCommit repository differently, then update this parameter accordingly.

![PipelineConfiguration](/images/screenshot-pipeline-cfn-2.png)

The `DeployStackName` is pre-populated with `sam-app` as well. This value refers to the name of the CloudFormation stack for the SAM app that your pipeline will be deploying. You did this on Chapter 3. Click Next.

![PipelineConfiguration](/images/screenshot-pipeline-cfn-3.png)

On the next screen, leave everything as is and just click Next.

![PipelineConfiguration](/images/screenshot-pipeline-cfn-4.png)

Finally, scroll down, tick the checkbok and click Next.

![PipelineConfiguration](/images/screenshot-pipeline-cfn-5.png)

### Wait for creation

After a couple of minutes, your pipeline should be provisioned.

![PipelineConfiguration](/images/screenshot-pipeline-cfn-6.png)