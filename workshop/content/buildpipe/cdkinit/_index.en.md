+++
title = "Setup a CDK project"
date = 2019-11-01T15:26:09-07:00
weight = 21
+++

First of all, install the CDK CLI by running the following command from your terminal.
```
npm install -g aws-cdk
```

### Initialize project

Now, let's create a folder within our _sam-app_ directory where the pipeline code will reside.
```
cd ~/environment/sam-app
mkdir pipeline
cd pipeline
```

Initialize a new CDK project within the _pipeline_ folder by running the following commands:

```
cdk init --language typescript
npm install --save @aws-cdk/aws-codedeploy @aws-cdk/aws-codebuild
npm install --save @aws-cdk/aws-codecommit @aws-cdk/aws-codepipeline-actions
npm install --save @aws-cdk/aws-s3
```

After a few seconds, our new CDK project should look like this:

![CdkInit](/images/chapter4/screenshot-cdk-init.png)

The main file that you will be interacting with is the `lib/pipeline-stack.ts`. And the entry point of your CDK project is `bin/pipeline.ts`. For this workshop, don't worry about the rest of the files and folders, although if you are curious, feel free to poke around the project structure. 
