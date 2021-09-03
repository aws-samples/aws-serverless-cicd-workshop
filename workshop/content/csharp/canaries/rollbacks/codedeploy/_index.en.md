+++
title = "Watch CodeDeploy rollback"
date = 2021-08-30T08:30:00-06:00
weight = 15
+++

Navigate to the [AWS CodeDeploy Console](https://console.aws.amazon.com/codedeploy/home) and go into the deployment In-Progress to view its details. 

After a few minutes, CodeDeploy will detect that the _CanaryErrorsAlarm_ has triggered and it will start rolling back the deployment. The screen will look something like this: 

![CodeDeployRollback](/images/csharp/canaries/aws_console_codedeploy_deployment_cancelled.png)