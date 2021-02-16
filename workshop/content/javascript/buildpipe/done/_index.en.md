+++
title = "Verify pipeline"
date = 2019-11-05T14:20:52-08:00
weight = 35
+++

Let your pipline run every stage. After it finishes it will look all green like the following screenshot:

![VerifyPipelineRunning](/images/chapter4/screenshot-pipeline-verify-3.png)

### Push the changes

In the terminal, run the following commands from the root directory of your `sam-app` project.

```
git add .
git commit -m "CI/CD Pipeline definition"
git push
```

#### Congratulations! You have created a CI/CD pipeline for a Serverless application!
