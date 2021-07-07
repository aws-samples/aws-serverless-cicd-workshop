+++
title = "Verify deployment"
date = 2019-10-03T13:52:29-07:00
weight = 25
+++

Now that your Serverless application is deployed to an AWS account, let's check if it is running as expected. 

### Open the CloudFormation console
Navigate to the [AWS CloudFormation console](https://console.aws.amazon.com/cloudformation/home), make sure you are in the same region where you have been working on so far. You should see the new stack _sam-app_ in the CREATE_COMPLETE status.

![CloudFormationHome](/images/screenshot-cfn-1.png)

### Test the app
Click on the **sam-app** stack and then go to the **Outputs** tab. In this tab, you will see the API Gateway URL, the Lambda function ARN and the IAM Role ARN for the function. To test our application, **copy the API Gateway endpoint URL and paste it in a new browser window**. 

![CloudFormationSamAppDev](/images/screenshot-cfn-2.png)

When you navigate to this URL in the browser, API Gateway is invoking the Hello World Lambda function. If everything works, you will see Lambda response:

![ApiGatewayVerify](/images/screenshot-api-1.png)

### Congratulations! 
You have successfully deployed a Serverless application! Let's automate deployments now! 
