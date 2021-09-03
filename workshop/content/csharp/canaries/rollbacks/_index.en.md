+++
title = "Rollbacks"
date = 2021-08-30T08:30:00-06:00
weight = 30
+++

Monitoring the health of your canary allows CodeDeploy to make a decision to whether a rollback is needed or not. If any of the CloudWatch Alarms specified gets to ALARM status, CodeDeploy rollsback the deployment automatically. 

### Introduce an error on purpose

Let's break the Lambda function on purpose so that the _CanaryErrorsAlarm_ gets triggered during deployment. Update the lambda code in `sam-app/src/HelloWorld/Function.cs` to throw an error on every invocation, like this:

```csharp
        public async Task<APIGatewayProxyResponse> FunctionHandler(APIGatewayProxyRequest apigProxyEvent, ILambdaContext context)
        {

            if (System.Environment.GetEnvironmentVariable("AWS_LAMBDA_FUNCTION_NAME") == null)
                throw new System.Exception("This will cause a deployment rollback");
```

Note: This error condition is not covered by the unit tests, so the build will not fail.


## Build the project

In the terminal, run the following commands to build the project.

```bash
cd ~/environment/sam-app/src/HelloWorld
dotnet build
```


### Push the changes

In the terminal, run the following commands from the root directory of your `sam-app` project.

```bash
cd ~/environment/sam-app
git add .
git commit -m "Breaking the lambda function on purpose"
git push
```
