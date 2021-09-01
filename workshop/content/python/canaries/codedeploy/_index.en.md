+++
title = "Verify in CodeDeploy"
date = 2021-08-30T08:30:00-06:00
weight = 25
+++

Wait for your pipeline to get to the **Deploy** stage (ExecuteChangeSet) and when you see it _In progress_. Navigate to the CodeDeploy console to watch the deployment progress.

![CanaryCodeDeploy](/images/python/canaries/aws_console_pipeline_deploy.png)

Navigate to the [AWS CodeDeploy](https://console.aws.amazon.com/codesuite/codedeploy/home) console and after a couple of minutes, you should see a new deployment in progress. Click on the **Deployment Id** to see the details.

![CanaryCodeDeploy](/images/python/canaries/aws_console_codedeploy_deployments.png)

{{% notice note %}}
If you are unable to catch the deployment _In progress_,  you can make a small change to the `app.py` such as changing the message back to "hello world" (but also make sure to change the unit test in `test_handler.py` back as well). 
{{% /notice %}}

The deployment status shows that 10% of the traffic has been shifted to the new version (aka The Canary). CodeDeploy will hold the remaining percentage until the specified time interval has ellapsed, in this case we specified the interval to be 5 minutes.

![CanaryCodeDeploy](/images/python/canaries/aws_console_codedeploy_deployment_status.png)

Shortly after the 5 minutes, the remaining traffic should be shifted to the new version:

![CanaryCodeDeploy](/images/python/canaries/aws_console_codedeploy_deployment_complete.png)

