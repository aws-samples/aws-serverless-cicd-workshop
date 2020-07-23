+++
title = "Explore the SAM template"
date = 2019-10-02T14:45:41-07:00
weight = 10
+++

Let's take a moment to understand the structure of a SAM application by exploring the SAM template which represents the architecture of your Serverless application. Go ahead and open the `sam-app/template.yaml` file.

![SAMTemplate](/images/screenshot-init-sam-template-0.png)

It should have a structure like the following.

![SAMTemplate](/images/screenshot-init-sam-template.png)

You may notice that the syntax looks exactly like AWS CloudFormation, this is because SAM templates are an extension of CloudFormation templates. That is, any resource that you can declare in CloudFormation, you can also declare in a SAM template. Let's take a closer look at the components of the template.

### Transform
Notice the transform line of the template, it tells CloudFormation that this template adheres to the open source [AWS Serverless Application Model specification](https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md):

![SAMTemplateTransform](/images/screenshot-sam-template-2.png)

### Globals
This section defines properties common to all your Serverless functions and APIs. In this case, it's specifying that all functions in this project will have a default timeout of 3 seconds.

![SAMTemplateGlobals](/images/screenshot-sam-template-3.png)

### Hello World Function
The following section creates a Lambda function with an IAM execution role. It also specifies that the code for this Lambda function is located under a folder named _hello-world_, and that its entrypoint is a function named _lambdaHandler_ within a file named _app.js_. 

![SAMTemplateFunction](/images/screenshot-sam-template-4.png) 

Notice that the IAM role is not explicitly specified, this is because SAM will create a new one by default. You can  override this behavior and pass your own role by specifying the _Role_ parameter. For a complete list of the parameters you can specify for a Lambda function check the [SAM reference](https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md#awsserverlessfunction).

### Event Triggers
This section is part of the function definition and it specifies the different events that will trigger the Lambda function. In this case, we are specifying the event to be an API Gateway with an endpoint on `/hello` that will listen on HTTP method `GET`. 

![SAMTemplateEvents](/images/screenshot-sam-template-5.png)

### Outputs
The Outputs section is optional and it declares output values that you can import into other CloudFormation stacks (to create cross-stack references), or simply to view them on the CloudFormation console. In this case we are making the API Gateway endpoint URL, the Lambda function ARN and the IAM Role ARN available as Outputs to make them easier to find.

![SAMTemplateOutputs](/images/screenshot-sam-template-6.png)