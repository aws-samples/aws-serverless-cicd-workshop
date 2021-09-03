+++
title = "How does it work"
date = 2021-08-30T08:30:00-06:00
weight = 10
+++

Before we jump into implementing Canary Deployments, lets first understand how this works: 

The concepts of blue/green and canary deployments have been around for a while and have been well-established as best-practices for reducing the risk of software deployments. In traditional applications, you slowly and incrementally update the servers in your fleet while simultaneously verifying application health. However, there is somewhat of an impedance mismatch when mapping these concepts to a serverless world. You can’t incrementally deploy your software across a fleet of servers when there are no servers! 

The answer is that there are a couple of services and features involved in making this possible. Let us explain: 

### Lambda versions and aliases

AWS Lambda allows you to publish multiple versions of the same function. Each version has its own code and associated dependencies, as well as its own function settings (like memory allocation, timeout and environment variables). You can then refer to a given version by using a Lambda Alias. An alias is nothing but a name that can be pointed to a given version of a Lambda function.

![VersionsAndAliases](/images/lambda-versions-aliases.png)

### Traffic shifting with Lambda aliases

With the introduction of alias traffic shifting, it is now possible to trivially implement canary deployments of Lambda functions. By updating additional version weights on an alias, invocation traffic is routed to the new function versions based on the weight specified. Detailed CloudWatch metrics for the alias and version can be analyzed during the deployment, or other health checks performed, to ensure that the new version is healthy before proceeding.

![TrafficShifting](/images/traffic-shifting.png)

### Traffic shifting with SAM and CodeDeploy

 AWS CodeDeploy provides an intuitive turn-key implementation of this functionality integrated directly into AWS SAM. Traffic-shifted deployments can be declared in a SAM template, and CodeDeploy manages the function rollout as part of the CloudFormation stack update. CloudWatch alarms can also be configured to trigger a stack rollback if something goes wrong.

 ![TrafficShiftingCodeDeploy](/images/traffic-shifting-codedeploy.png)