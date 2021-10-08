+++
title = "Pipeline as code"
date = 2021-08-30T08:30:00-06:00
weight = 22
+++

Open the file `pipeline/pipeline_stack.py` in your Cloud9 workspace. It is empty at the moment, but here is where you will be adding code to build your CI/CD pipeline.

![CdkEmptyLib](/images/python/buildpipe/cloud9_ide_pipeline_stack.png) 

### Deploy a CDK project

Even though we haven't wrote any code yet, let's get familiar with how todeploy a CDK project, as you will be doing it multiple times in this workshop and you should get comfortable with the process. Go ahead and deploy the pipeline project by using the CDK CLI:

```bash
cdk deploy
```

The output should look like the following:

![CdkDeploy](/images/python/buildpipe/cdk_deploy.png) 

A new CloudFormation stack was created in your account, but because your CDK project is empty, the only resource that was created was an AWS::CDK::Metadata. If you check your [CloudFormation Console](https://console.aws.amazon.com/cloudformation/home), you will see the new stack and the metadata resource. 

![CdkMetadata](/images/python/buildpipe/aws_console_cloudformation_samcicd.png) 