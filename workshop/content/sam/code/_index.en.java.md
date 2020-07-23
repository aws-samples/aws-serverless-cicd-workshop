+++
title = "Explore the Lambda code"
date = 2019-10-02T15:21:26-07:00
weight = 15
+++

{{% notice note %}}
If you consider yourself an expert using Lambda functions, you can probably skip this page.
{{% /notice%}}

Let's take a look at the code of the Hello World Lambda function. Open the file `App.java` under the `HelloWorldFunction/src/main/java/helloworld` folder.

![ScreenshotLambdaCode](/images/java/chapter1/code/lambda-code.png)

### The Lambda handler
The handler is the method in your Lambda function that processes events. When you invoke a function, the runtime runs the handler method. When the handler exits or returns a response, it becomes available to handle another event. In this case, the lambda handler is the `handleRequest` function, as specified in the SAM `template.yaml`. 

{{% notice tip %}}
Because the Lambda handler is executed on every invocation, a best practice is to place code that can be reused across invocations outside of the handler scope. A common example is to initialize database connections outside of the handler.
{{% /notice%}}

#### Event object
The first argument passed to the handler function is the `APIGatewayProxyRequestEvent` object, which contains information from the invoker. In this case, the invoker is API Gateway, which passes the HTTP request information as a JSON-formatted string, and the Lambda runtime converts it to an object. You can find examples of event payloads here: [https://docs.aws.amazon.com/lambda/latest/dg/lambda-services.html](https://docs.aws.amazon.com/lambda/latest/dg/lambda-services.html)

#### Context object
The second argument is the context object, which contains information about the invocation, function, and execution environment. You can get information like the CloudWatch log stream name or the remaining execution time for the function.

#### Handler Response
API Gateway expects the handler to return a response object that contains _statusCode_ and _body_, but it can also contain optional _headers_. In this example this is represented by the `APIGatewayProxyResponseEvent` object.