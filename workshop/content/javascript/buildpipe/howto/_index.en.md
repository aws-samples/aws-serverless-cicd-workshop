+++
title = "How to build a pipeline"
date = 2019-11-01T15:26:09-07:00
weight = 20
+++

The best way to automate the creation of CI/CD pipelines is by provisioning them programmatically
using Infrastructure as Code (IaC). This is useful in a microservices environment, where you may have
a pipeline per microservice. In such environments there could be dozens, or even hundreds,
of CI/CD pipelines. Having an automated way to create those CI/CD pipelines enables developers move quickly
without the burden of building them manually. SAM Pipelines, which you'll be using, is a tool to
ease that burden.

### Different ways to create cloud infrastructure

Technical teams use different IaC tools and frameworks to create cloud resources programmatically. A few
options are listed below.

- [AWS SAM](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
- [AWS CloudFormation](https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials.html)
- [AWS CDK](https://docs.aws.amazon.com/cdk/latest/guide/codepipeline_example.html)
- [Terraform](https://www.terraform.io/docs/providers/aws/r/codepipeline.html)

In this workshop we are using AWS SAM, exlusively.
It's worth clarifying the differences between AWS SAM and CloudFormation if you're unfamiliar. It
may be helpful to think of SAM as a higher level programming language like C or C++, and
CloudFormation as assembly language. We do our work in AWS SAM which generates and deploys
CloudFormation templates on our behalf. In previous sections we also used `sam local` commands to
test our serverless application locally. AWS SAM is a toolset meant to increase productivity when
developing serverless applications and provides capabilities such as `sam local` that are not
present in other IaC tools.

In this section you will be using another feature from SAM to create a CI/CD pipeline.

### Introducing AWS SAM Pipelines

[**SAM Pipelines**](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-pipeline-bootstrap.html)
works by creating a set of configuration and infrastructure files you use to create and manage your
CI/CD pipeline.

As of this writing, SAM Pipelines can bootstrap CI/CD pipelines for the following providers:

- Jenkins
- GitLab CI/CD
- GitHub Actions
- Bitbucket Pipelines
- AWS CodePipeline

{{% notice note %}}
SAM Pipelines is a feature which bootstraps CI/CD pipelines for the listed providers. This saves
saves you the work of setting them up from scratch. However, you can use SAM as a deployment tool
with _any_ CI/CD provider. You use the `sam build` and `sam deploy` commands to build and deploy SAM
applications regardless of your CI/CD toolset. Furthermore, the configurations SAM Pipelines creates
are a convienence to get you started quickly. You are free to edit these CI/CD configuration
files after SAM creates them.
{{% /notice %}}

SAM Pipelines creates appropriate configuration files for your CI/CD provider of choice. For
exampoe, when using
GitHub Actions SAM will synthesize a `.github/workflows/pipeline.yaml` file. This file defines your CI/CD
pipeline using GitHub Actions. In this workshop we will be using AWS CodePipeline. As you will soon
see, SAM creates multiple files, one of which is a CloudFormation template named
`codepipeline.yaml`. This template defines multiple AWS resources that work together to deploy our
serverless application automatically.

### CodePipeline architecture

At the end of this section we will have a self-updating CI/CD pipeline using CodePipeline that will
perform the following steps.

1. Trigger after a commit to the `main` branch
1. Look for changes to the pipeline itself, and self-update using CloudFormation
1. Run unit tests via CodeBuild
1. Build and package the application code via CodeBuild
1. Deploy to a dev/test environment
1. Deploy to a production environment

![](/images/sam-pipeline-architecture.png)
