+++
title = "Artifacts Bucket"
date = 2019-11-01T15:26:09-07:00
weight = 10
+++

Every Code Pipeline needs an artifacts bucket, also known as Artifact Store. CodePipeline will use this bucket to pass artifacts to the downstream jobs and its also where SAM will upload the artifacts during the build process. 

Let's get started and write the code for creating this bucket:

**Make sure you are editing the PipelineStack.java file.**

```java
package com.myorg;

import software.amazon.awscdk.core.Construct;
import software.amazon.awscdk.core.Stack;
import software.amazon.awscdk.core.StackProps;
import software.amazon.awscdk.services.s3.Bucket;

public class PipelineStack extends Stack {
    public PipelineStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public PipelineStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        Bucket artifactsBucket = new Bucket(this, "ArtifactsBucket");
    }
}
```

If we try to deploy our code now, we'll have a problem due to a test failure. To focus on the pipeline we'll delete the 
tests for now.

![CdkBucket](/images/java/chapter4/pipeascode/delete-tests.png)

Now lets build and deploy the project: 

```
mvn clean package
cdk deploy
```