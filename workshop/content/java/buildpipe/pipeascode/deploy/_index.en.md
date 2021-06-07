+++
title = "Deploy stage"
date = 2019-10-04T12:54:48-07:00
weight = 40
+++

The **Deploy Stage** is where your SAM application and all its resources are created in an AWS account. The most common way to do this is by using CloudFormation ChangeSets to deploy. This means that this stage will have 2 actions: the _CreateChangeSet_ and the _ExecuteChangeSet_.

Add the Deploy stage to your PipelineStack.java: 

```java
// Deploy stage
CloudFormationCreateReplaceChangeSetAction createChangeSet = new CloudFormationCreateReplaceChangeSetAction(CloudFormationCreateReplaceChangeSetActionProps.builder()
        .actionName("CreateChangeSet")
        .templatePath(buildOutput.atPath("packaged.yaml"))
        .stackName("sam-app")
        .adminPermissions(true)
        .changeSetName("sam-app-dev-changeset")
        .runOrder(1)
        .build());

CloudFormationExecuteChangeSetAction executeChangeSet = new CloudFormationExecuteChangeSetAction(CloudFormationExecuteChangeSetActionProps.builder()
        .actionName("Deploy")
        .stackName("sam-app")
        .changeSetName("sam-app-dev-changeset")
        .runOrder(2)
        .build());

pipeline.addStage(StageOptions.builder()
        .stageName("Dev")
        .actions(Arrays.asList(createChangeSet, executeChangeSet))
        .build());
```

{{%expand "Click here to see how the entire file should look like" %}}

The highlighted code is the new addition: 

{{< highlight js "hl_lines=70-94" >}}
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

        // The code that defines your stack goes here
        
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
                
        CloudFormationCreateReplaceChangeSetAction createChangeSet = new CloudFormationCreateReplaceChangeSetAction(CloudFormationCreateReplaceChangeSetActionProps.builder()
                .actionName("CreateChangeSet")
                .templatePath(buildOutput.atPath("packaged.yaml"))
                .stackName("sam-app")
                .adminPermissions(true)
                .changeSetName("sam-app-dev-changeset")
                .runOrder(1)
                .build());

        CloudFormationExecuteChangeSetAction executeChangeSet = new CloudFormationExecuteChangeSetAction(CloudFormationExecuteChangeSetActionProps.builder()
                .actionName("Deploy")
                .stackName("sam-app")
                .changeSetName("sam-app-dev-changeset")
                .runOrder(2)
                .build());

        pipeline.addStage(StageOptions.builder()
                .stageName("Dev")
                .actions(Arrays.asList(createChangeSet, executeChangeSet))
                .build());
    }
}
{{< / highlight >}}
{{% /expand%}}

### Deploy the pipeline

On your terminal, run the following commands from within the _pipeline_ directory:

```
cd ~/environment/sam-app/pipeline
mvn package
cdk deploy
```

The CLI might ask you to confirm the changes before deploying, this is because we are giving Admin permissions to the IAM role that deploys our application. This is generally **not** a bad practice since this role can only be assumed by CloudFormation and not by a human, however, if your organization has a stricter security posture you may want to consider creating [a custom IAM deployment role](https://docs.aws.amazon.com/cdk/api/latest/docs/@aws-cdk_aws-iam.Role.html) with a fine grain policy. 

### Trigger a release

Navigate to your pipeline and you will see the Deploy stage has been added, however, it is currently grayed out because it hasn't been triggered. Let's just trigger a new run of the pipeline manually by clicking the Release Change buttton. 

![ReleaseChange](/images/chapter4/screenshot-release-change.png)
