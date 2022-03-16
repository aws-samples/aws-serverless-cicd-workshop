+++
title = "Inspect deployment"
date = 2019-10-03T13:52:29-07:00
weight = 25
+++

In the previous section we deployed and tested our serverless application. If you are new to AWS
SAM, it's good to understand how it creates resources with CloudFormation.

### Open the CloudFormation console

Navigate to the [AWS CloudFormation console](https://console.aws.amazon.com/cloudformation/home),
make sure you are in the same region where you have been working on so far. You should see the new
stack `sam-app` in the `CREATE_COMPLETE` status.

![CloudFormationHome](/images/screenshot-cfn-1.png)

### View CloudFormation Outputs

Remember that our AWS SAM template defines three `Outputs`, at the bottom of the `template.yaml`
file.

```yaml
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

You saw in the previous section how the values of these variables are emitted to the console during
deployment. It is useful to recognize that these are standard [**CloudFormation
Outputs**](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/outputs-section-structure.html).

You can see these `Outputs` values in the CloudFormation console. Click on the `sam-app` stack and
then go to the `Outputs` tab. In this tab, you will see the API Gateway URL, the Lambda function ARN
and the IAM Role ARN for the function.

![CloudFormationSamAppDev](/images/screenshot-cfn-2.png)

### Delete the app

In the next section we are going to setup a CI/CD pipeline with SAM. Because of this, we don't need
this SAM application that we manually deployed.

To delete the application run `sam delete`. Answer `y` to all of the prompts.

```text
sam delete

    Are you sure you want to delete the stack sam-app in the region us-west-2 ? [y/N]: y
    Are you sure you want to delete the folder sam-app in S3 which contains the artifacts? [y/N]: y
```

### Congratulations!

You have successfully deployed, tested and deleted a Serverless application! Now, let's automate
deployments!
