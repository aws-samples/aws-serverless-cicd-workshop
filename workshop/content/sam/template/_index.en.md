+++
title = "Explore the SAM template"
date = 2019-10-02T14:45:41-07:00
weight = 10
+++

Let's take a moment to understand the structure of a SAM application by exploring the SAM template
which represents the architecture of your Serverless application. Go ahead and open the
`sam-app/template.yaml` file.

It should have a structure like the following. This is a Node application and your `template.yaml`
will look slightly different if using a different runtime.

```yaml
AWSTemplateFormatVersion: "2010-09-09"
Transform: AWS::Serverless-2016-10-31
Description: >
  sam-app

  Sample SAM Template for sam-app

Globals:
  Function:
    Timeout: 3

Resources:
  HelloWorldFunction:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: hello-world/
      Handler: app.lambdaHandler
      Runtime: nodejs16.x
      Events:
        HelloWorld:
          Type: Api
          Properties:
            Path: /hello
            Method: get

Outputs:
  HelloWorldApi:
    Description: "API Gateway endpoint URL for Prod stage for Hello World function"
    Value: !Sub "https://${ServerlessRestApi}.execute-api.${AWS::Region}.amazonaws.com/Prod/hello/"
  HelloWorldFunction:
    Description: "Hello World Lambda Function ARN"
    Value: !GetAtt HelloWorldFunction.Arn
  HelloWorldFunctionIamRole:
    Description: "Implicit IAM Role created for Hello World function"
    Value: !GetAtt HelloWorldFunctionRole.Arn
```

You may notice that the syntax looks exactly like AWS CloudFormation, this is because SAM templates are an extension of CloudFormation templates. That is, any resource that you can declare in CloudFormation, you can also declare in a SAM template. Let's take a closer look at the components of the template.

### Transform

Notice the transform line of the template highlighed below. This line tells CloudFormation that
the template adheres to the open source [AWS Serverless Application Model specification](https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md):

```yaml {hl_lines=["2"]}
AWSTemplateFormatVersion: "2010-09-09"
Transform: AWS::Serverless-2016-10-31
Description: >
  sam-app

  Sample SAM Template for sam-app
```

### Globals

This section defines properties common to all your Serverless functions and APIs. In this case, it's specifying that all functions in this project will have a default timeout of 3 seconds.

```yaml
Globals:
  Function:
    Timeout: 3
```

### Hello World Function

The following section creates a Lambda function with an IAM execution role. It also specifies that
the code for this Lambda function is located under a folder specified in the `CodeUri` key. The
`Handler` key defines the file and function name of the entrypoint.

{{< tabs >}}

{{% tab name="Node" %}}

The entrypoint is a function named `lambdaHandler` within a file named `app.js` in the
`hello-world/` directory.

```yaml
HelloWorldFunction:
  Type: AWS::Serverless::Function
  Properties:
    CodeUri: hello-world/
    Handler: app.lambdaHandler
    Runtime: nodejs16.x
    Events:
      HelloWorld:
        Type: Api
        Properties:
          Path: /hello
          Method: get
```

{{% /tab %}}

{{% tab name="Python" %}}

The entrypoint is a function named `lambda_handler` within a file named `app.py` in the
`hello_world/` directory.

```yaml
HelloWorldFunction:
  Type: AWS::Serverless::Function
  Properties:
    CodeUri: hello_world/
    Handler: app.lambda_handler
    Runtime: python3.7
    Events:
      HelloWorld:
        Type: Api
        Properties:
          Path: /hello
```

{{% /tab %}}

{{% /tabs %}}

Notice that the IAM role is not explicitly specified, this is because SAM will create a new one by default. You can override this behavior and pass your own role by specifying the _Role_ parameter. For a complete list of the parameters you can specify for a Lambda function check the [SAM reference](https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md#awsserverlessfunction).

### Event Triggers

The `Events` section highlighted below is part of the function definition. This section specifies the
different events that will trigger the Lambda function. In this case, we are specifying an HTTP `GET`
request to an API Gateway with an endpoint of `/hello`.

```yaml {hl_lines=["7-12"]}
HelloWorldFunction:
  Type: AWS::Serverless::Function
  Properties:
    CodeUri: hello-world/
    Handler: app.lambdaHandler
    Runtime: nodejs16.x
    Events:
      HelloWorld:
        Type: Api
        Properties:
          Path: /hello
          Method: get
```

### Outputs

The Outputs section is optional and it declares output values that you can import into other
CloudFormation stacks (to create cross-stack references), or simply to view them on the
CloudFormation console. In this case we are making the API Gateway endpoint URL, the Lambda function
ARN and the IAM Role ARN available as Outputs to make them easier to find.

```yaml
Outputs:
  # ServerlessRestApi is an implicit API created out of Events key under Serverless::Function
  # Find out more about other implicit resources you can reference within SAM
  # https://github.com/awslabs/serverless-application-model/blob/master/docs/internals/generated_resources.rst#api
  HelloWorldApi:
    Description: "API Gateway endpoint URL for Prod stage for Hello World function"
    Value: !Sub "https://${ServerlessRestApi}.execute-api.${AWS::Region}.amazonaws.com/Prod/hello/"
  HelloWorldFunction:
    Description: "Hello World Lambda Function ARN"
    Value: !GetAtt HelloWorldFunction.Arn
  HelloWorldFunctionIamRole:
    Description: "Implicit IAM Role created for Hello World function"
    Value: !GetAtt HelloWorldFunctionRole.Arn
```
