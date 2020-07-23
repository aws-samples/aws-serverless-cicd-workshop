+++
title = "How to build a pipeline"
date = 2019-11-01T15:26:09-07:00
weight = 20
+++

The best way to automate the creation of CI/CD pipelines is by provisioning them programmatically via Infrastructure as Code. This is specially useful in a microservices environment, where you have a pipeline per microservice, which potentially means dozens of pipelines, if not more. Having an automated way to create these pipelines enables developers to create as many as necessary without building them manually from the console every time.

### Different ways to create pipelines
We see customers using different mechanisms for creating pipelines programmatically. Nowadays developers have many choices to pick from, but the most common ones we see are the following:

- [AWS CloudFormation](https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials.html)
- [AWS CDK](https://docs.aws.amazon.com/cdk/latest/guide/codepipeline_example.html)
- [Terraform](https://www.terraform.io/docs/providers/aws/r/codepipeline.html)
- [AWS Serverless App Repository](https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:646794253159:applications~aws-sam-codepipeline-cd)

### Introducing the AWS CDK
In this workshop, we are going to use the AWS Cloud Development Kit (also known as CDK), as the pipeline vending mechanism. The AWS CDK is a software development framework for defining cloud infrastructure in code and provisioning it through AWS CloudFormation.

That's right! You can describe your infrastructure by writing code in TypeScript, C#, Python or Java. Your code is then synthesized into CloudFormation and using the CDK CLI you can deploy it to an AWS account. 

### How does SAM and CDK play together?

Serverless developers use the SAM framework to define their applications, SAM CLI to build them and deploy them and AWS CDK to provision any infrastructure related resources, like their CI/CD Pipeline. The nice thing about these tools is that they all share a common ground: CloudFormation. 