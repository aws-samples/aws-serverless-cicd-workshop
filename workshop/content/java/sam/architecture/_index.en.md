+++
title = "Project Architecture"
date = 2019-11-01T16:12:35-07:00
weight = 6
+++

The Hello World SAM project you just created will create the following architecture when deployed. It has a single Lambda function, an API Gateway that exposes a _/hello_ resource and invokes the Lambda function when called with an HTTP GET request. The Lambda function assumes an IAM role that can have permissions to interact with other AWS resources, like a database for example.

![SAMInitArchitecture](/images/serverless-architecture.png)


#### In the next page, we will explore the structure and code of a SAM project.