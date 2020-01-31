+++
title = "Verify creation"
date = 2019-11-04T16:10:09-08:00
weight = 25
+++

Navigate to the [AWS CodePipeline Console](https://console.aws.amazon.com/codesuite/codepipeline/home) and click on your pipeline name to check its details. 

![VerifyPipeline](/images/screenshot-pipeline-verify-1.png)

The Build step should have failed. **This is expected** because we haven't specified what commands to run on the build yet. 

![VerifyPipeline](/images/screenshot-pipeline-verify-2.png)