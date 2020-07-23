+++
title = "Source Stage"
date = 2019-11-01T15:26:09-07:00
weight = 15
+++

The **Source Stage** is the first step of any CI/CD pipeline and it represents your source code. This stage is in charge of triggering the pipeline based on new code changes (i.e. git push or pull requests). In this workshop, we will be using AWS CodeCommit as the source provider, but CodePipeline also supports S3, GitHub and Amazon ECR as source providers.

Append the following code snippet after your bucket definition in the **PipelineStack.java** file:

```java
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
```

You will also need the following imports. We'll add all the imports we will need now for the workshop.

```java
import software.amazon.awscdk.services.codebuild.*;
import software.amazon.awscdk.services.codecommit.*;
import software.amazon.awscdk.services.codepipeline.*;
import software.amazon.awscdk.services.codepipeline.actions.*;
import java.util.*;
import static software.amazon.awscdk.services.codebuild.LinuxBuildImage.AMAZON_LINUX_2;
```

{{%expand "Click here to see how the entire file should look like" %}}

The highlighted code is the new addition: 

{{< highlight java "hl_lines=24-40" >}}
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
    }
}
{{< / highlight >}}
{{% /expand%}}

Since we already have the CodeCommit repository, we don't need to create a new one, we just need to import it using the repository name. 

Also notice how we define an object `sourceOutput` as a pipeline artifact; This is necessary for any files that you want CodePipeline to pass to downstream stages. In this case, we want our source code to be passed to the Build stage.

{{% notice info %}}
Don't do a `cdk deploy` just yet, because a pipeline needs to have at least 2 stages to be created. Lets continue to the next page to add a Build stage first.
{{% /notice%}}
