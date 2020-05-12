+++
title = "Introduction"
date = 2019-11-11T14:46:02-08:00
weight = 15
draft = true
hidden = true
+++

### Environment separation

Separating environments into different AWS accounts its a common practice among AWS customers. The most basic form of separation is to have 2 AWS accounts, one for non-production environments and one dedicated to Production. This gives developers the ability to have full admin permissions in the Dev environment, to iterate and experiment quickly, and have _limited_ permissions in the Production account.

The following diagram illustrates a simple setup of 2 accounts, one for Dev and one for Prod. This is the setup we will be using as reference throughout this chapter, but the concepts learned can be applied to any form of multi-account setup. 

![EnvironmentSeparation](/images/chapter6/environment-separation.png)

As you can see from the diagram, the Dev account hosts the Code Pipeline, S3 bucket for artifacts and the code repository. The pipeline then deploys across the Production account using IAM [assumed roles](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html).