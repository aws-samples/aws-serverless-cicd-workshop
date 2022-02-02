+++
title = "Monitor canary health"
date = 2019-11-11T16:24:12-08:00
weight = 25
+++

Canary deployments are considerably more successful if the code is being monitored during the
deployment. You can configure CodeDeploy to automatically roll back the deployment if a specified
CloudWatch metric has breached the alarm threshold. Common metrics to monitor are Lambda Invocation
errors or Invocation Duration (latency), for example.

### Define a CloudWatch Alarm

Add the following alarm definition to the `template.yaml` file in the _Resources_ section after the _HelloWorldFunction_ definition.

```yaml
CanaryErrorsAlarm:
  Type: AWS::CloudWatch::Alarm
  Properties:
    AlarmDescription: Lambda function canary errors
    ComparisonOperator: GreaterThanThreshold
    EvaluationPeriods: 2
    MetricName: Errors
    Namespace: AWS/Lambda
    Period: 60
    Statistic: Sum
    Threshold: 0
    Dimensions:
      - Name: Resource
        Value: !Sub "${HelloWorldFunction}:live"
      - Name: FunctionName
        Value: !Ref HelloWorldFunction
      - Name: ExecutedVersion
        Value: !GetAtt HelloWorldFunction.Version.Version
```

Change the `DeploymentPreference` section of the `HelloWorldFunction`
definition. You will configure the `dev` stage to use the `AllAtOnce` deployment strategy and `prod` to
use the canary method. This will make your deployments for `dev` faster and show you how to configure your SAM
template using CloudFormation Conditions.

```yaml
DeploymentPreference:
  Type: !If [IsProduction, "Canary10Percent5Minutes", "AllAtOnce"]
  Alarms: !If [IsProduction, [!Ref CanaryErrorsAlarm], []]
```

You will also need to add the `IsProduction` Condition statement after the `Globals` section.

```yaml
Conditions:
  IsProduction: !Equals [!Ref "AWS::StackName", "sam-app-prod"]
```

Your `template.yaml` should look like this:

```yaml {linenos=true,hl_lines=["12-13","23-25","33-50"]}
AWSTemplateFormatVersion: "2010-09-09"
Transform: AWS::Serverless-2016-10-31
Description: >
  sam-app

  Sample SAM Template for sam-app

Globals:
  Function:
    Timeout: 3

Conditions:
  IsProduction: !Equals [!Ref "AWS::StackName", "sam-app-prod"]

Resources:
  HelloWorldFunction:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: hello-world/
      Handler: app.lambdaHandler
      Runtime: nodejs14.x
      AutoPublishAlias: live
      DeploymentPreference:
        Type: !If [IsProduction, "Canary10Percent5Minutes", "AllAtOnce"]
        Alarms: !If [IsProduction, [!Ref CanaryErrorsAlarm], []]
      Events:
        HelloWorld:
          Type: Api
          Properties:
            Path: /hello
            Method: get

  CanaryErrorsAlarm:
    Type: AWS::CloudWatch::Alarm
    Properties:
      AlarmDescription: Lambda function canary errors
      ComparisonOperator: GreaterThanThreshold
      EvaluationPeriods: 2
      MetricName: Errors
      Namespace: AWS/Lambda
      Period: 60
      Statistic: Sum
      Threshold: 0
      Dimensions:
        - Name: Resource
          Value: !Sub "${HelloWorldFunction}:live"
        - Name: FunctionName
          Value: !Ref HelloWorldFunction
        - Name: ExecutedVersion
          Value: !GetAtt HelloWorldFunction.Version.Version

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

### Validate the SAM template

Run the following command on your terminal:

```
cd ~/environment/sam-app
sam validate
```

If the template is correct, you will see `template.yaml is a valid SAM Template`. If you see an
error, then you likely have an indentation issue on the YAML file. Double check and make sure it
matches the screenshot shown above.
