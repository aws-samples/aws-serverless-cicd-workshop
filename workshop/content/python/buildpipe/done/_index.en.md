+++
title = "Verify pipeline"
date = 2021-08-30T08:30:00-06:00
weight = 35
+++

Let your pipeline run every stage. After it finishes it will look all green like the following screenshot:

![VerifyPipelineRunning](/images/python/buildpipe/pipeline_stages.png)

### Push the changes

In the terminal, run the following commands from the root directory of your `sam-app` project.

```bash
git add .
git commit -m "CI/CD Pipeline definition"
git push
```

#### Congratulations! You have created a CI/CD pipeline for a Serverless application!
