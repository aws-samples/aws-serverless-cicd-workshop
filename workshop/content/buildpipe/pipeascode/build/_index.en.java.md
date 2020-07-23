+++
title = "Build Stage"
date = 2019-11-01T15:26:09-07:00
weight = 20
+++

The **Build Stage** is where your Serverless application gets built and packaged by SAM. We are going to use AWS CodeBuild as the Build provider for our pipeline. It is worth mentioning that CodePipeline also supports other providers like Jenkins, TeamCity or CloudBees. 

### Why AWS Code Build?

AWS CodeBuild is a great option because you only pay for the time where your build is running, which makes it very cost effective compared to running a dedicated build server 24 hours a day when you really only build during office hours. It is also container-based which means that you can bring your own Docker container image where your build runs, or [use a managed image](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html) provided by CodeBuild.  

### Add the build stage

Let's go ahead and add a Build stage to you PipelineStack.java:

```java
// Declare build output as artifacts
Artifact buildOutput = new Artifact("buildOutput");

// Declare a new CodeBuild project
PipelineProject buildProject = new PipelineProject(this, "Build", PipelineProjectProps.builder()
        .environment(BuildEnvironment.builder()
                .buildImage(AMAZON_LINUX_2).build())
        .environmentVariables(Collections.singletonMap("PACKAGE_BUCKET", BuildEnvironmentVariable.builder()
                .value(artifactsBucket.getBucketName())
                .build()))
        .build());

// Add the build stage to our pipeline
CodeBuildAction buildAction = new CodeBuildAction(CodeBuildActionProps.builder()
        .actionName("Build")
        .project(buildProject)
        .input(sourceOutput)
        .outputs(Collections.singletonList(buildOutput))
        .build());

pipeline.addStage(StageOptions.builder()
        .stageName("Build")
        .actions(Collections.singletonList(buildAction))
        .build());
```

{{%expand "Click here to see how the entire file should look like" %}}

The highlighted code is the new addition: 

{{< highlight js "hl_lines=45-65" >}}
// PipelineStack.java
package com.myorg;

import software.amazon.awscdk.core.Construct;
import software.amazon.awscdk.core.Stack;
import software.amazon.awscdk.core.StackProps;
import software.amazon.awscdk.services.codebuild.*;
import software.amazon.awscdk.services.codecommit.*;
import software.amazon.awscdk.services.codepipeline.*;
import software.amazon.awscdk.services.codepipeline.actions.*;
import software.amazon.awscdk.services.s3.Bucket;

import java.util.*;

import static software.amazon.awscdk.services.codebuild.LinuxBuildImage.AMAZON_LINUX_2;

public class PipelineStack extends Stack {
    public PipelineStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public PipelineStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        Bucket artifactsBucket = new Bucket(this, "ArtifactsBucket");
        
        IRepository codeRepo = Repository.fromRepositoryName(this, "AppRepository", "sam-app");
    
        Pipeline pipeline = new Pipeline(this, "Pipeline", PipelineProps.builder()
                .artifactBucket(artifactsBucket).build());
    
        Artifact sourceOutput = new Artifact("sourceOutput");
    
        CodeCommitSourceAction codeCommitSource = new CodeCommitSourceAction(CodeCommitSourceActionProps.builder()
                .actionName("CodeCommit_Source")
                .repository(codeRepo)
                .output(sourceOutput)
                .build());
    
        pipeline.addStage(StageOptions.builder()
                .stageName("Source")
                .actions(Collections.singletonList(codeCommitSource))
                .build());
                
        Artifact buildOutput = new Artifact("buildOutput");

        PipelineProject buildProject = new PipelineProject(this, "Build", PipelineProjectProps.builder()
                .environment(BuildEnvironment.builder()
                        .buildImage(AMAZON_LINUX_2).build())
                .environmentVariables(Collections.singletonMap("PACKAGE_BUCKET", BuildEnvironmentVariable.builder()
                        .value(artifactsBucket.getBucketName())
                        .build()))
                .build());

        CodeBuildAction buildAction = new CodeBuildAction(CodeBuildActionProps.builder()
                .actionName("Build")
                .project(buildProject)
                .input(sourceOutput)
                .outputs(Collections.singletonList(buildOutput))
                .build());

        pipeline.addStage(StageOptions.builder()
                .stageName("Build")
                .actions(Collections.singletonList(buildAction))
                .build());
    }
}
{{< / highlight >}}
{{% /expand%}}

### Deploy the pipeline

From your terminal, run the following commands to deploy the pipeline:

```
mvn package
cdk deploy
```

### Verify pipeline creation

Navigate to the [AWS CodePipeline Console](https://console.aws.amazon.com/codesuite/codepipeline/home) and click on your newly created pipeline! 

![VerifyPipeline](/images/java/chapter4/build/pipeline-deployed.png)

The Build step should have failed. **Don't worry! this is expected** because we haven't specified what commands to run during the build yet, so AWS CodeBuild doesn't know how to build our Serverless application.

![VerifyPipeline](/images/java/chapter4/build/build-failed.png)

Let's fix that.