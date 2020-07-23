+++
title = "Pipeline as code"
date = 2019-11-01T15:26:09-07:00
weight = 22
+++

Open the file `src/main/java/com/myorg/PipelineStack.java` in your Cloud9 workspace. It is empty at the moment, but here is where you will be adding code to build your CI/CD pipeline.

![CdkEmptyLib](/images/java/chapter4/pipeascode/empty-stack.png)

### Build the CDK project

Even though we haven't wrote any code yet, let's get familiar with how to build and deploy a CDK project, as you will be doing it multiple times in this workshop and you should get comfortable with the process. Start by building the project with the following command: 

```
cd ~/environment/sam-app/pipeline
mvn package
```

### Deploy a CDK project

After the build has finished, go ahead and deploy the pipeline project by using the CDK CLI:

```
cdk deploy
```

The output should look like the following:

![CdkDeploy](/images/java/chapter4/pipeascode/cdk-deploy.png)

A new CloudFormation stack was created in your account, but because your CDK project is empty, the only resource that was created was an AWS::CDK::Metadata. If you check your [CloudFormation Console](https://console.aws.amazon.com/cloudformation/home), you will see the new stack and the metadata resource. 

![CdkMetadata](/images/java/chapter4/pipeascode/stack-deployed.png)