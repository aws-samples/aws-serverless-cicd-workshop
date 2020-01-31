+++
title = "Verify pipeline running"
date = 2019-11-05T14:20:52-08:00
weight = 35
+++

Once you push the buildspec.yaml file into the code repository, the pipeline should trigger automatically. This time, the build step should succeed along with the deployment steps.

![VerifyPipelineRunning](/images/screenshot-pipeline-verify-3.png)

{{% notice tip %}}
This pipeline performs deployments using CloudFormation ChangeSets. If you are not familiar with them, you can learn about them here: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-changesets.html. 
{{% /notice %}}

#### Congratulations! You have created a CI/CD pipeline.