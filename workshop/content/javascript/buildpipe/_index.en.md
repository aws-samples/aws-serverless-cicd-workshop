+++
title = "Build the pipeline"
date = 2019-10-03T14:25:05-07:00
weight = 25
chapter = true
pre = "<b>4. </b>"
+++

# Build the pipeline

In this chapter you are going to learn how to automate the build, package and deploy commands by
creating a continous delivery pipeline using AWS Code Pipeline. We will be using [SAM
Pipelines](https://aws.amazon.com/blogs/compute/introducing-aws-sam-pipelines-automatically-generate-deployment-pipelines-for-serverless-applications/)
to generate and a self-updating, multi-stage CI/CD pipeline.

![SimplePipeline](/images/pipeline-art.png)

The services used in this chapter, via SAM Pipelines are CodeCommit, CodeBuild, CodePipeline and
CloudFormation.
