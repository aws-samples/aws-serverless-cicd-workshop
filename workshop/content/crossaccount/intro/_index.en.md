+++
title = "Introduction"
date = 2019-11-11T14:46:02-08:00
weight = 15
+++

### Environment separation

Separating environments (Dev, Test, Prod) into different AWS accounts is a very common practice among AWS customers. And the main motivation being the ability to give developers full administrative access to the Dev environment, so that they can innovate and iterate quickly, but give them _limited_ access to higher environments, like Production. There are other motivations as well, like managing [AWS Service Quotas](https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html) separately and having billing details broken down per environment. 

The following diagram illustrates a simple account setup that many customers start with. And we will also be using it throughout this chapter. But the concepts that you will learn here can be applied to any form of multi-account setup. 

![EnvironmentSeparation](/images/environment-separation.png)

As you can tell from the diagram, the Dev account hosts the Code Pipeline, Artifacts Bucket and the Code Repository. The CodePipeline then deploys across the Production account using an [assumed role](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html). 

