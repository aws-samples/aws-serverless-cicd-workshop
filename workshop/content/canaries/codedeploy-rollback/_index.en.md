+++
title = "Monitor rollback"
date = 2019-11-12T13:21:38-08:00
weight = 40
+++

Navigate to your pipeline in the CodePipeline console and keep an eye on its progression. You will
see that the `DeployTest` stage is deployed quickly since it's using the `AllAtOnce` strategy. Even
though our code is broken, thanks to our hard coded error, it's deployed automatically in the
`DeployTest` stage.

![CodeDeployDevSuccess](/images/canary-deployment-dev-success.png)

Once your pipeline moves to the `DeployProd` stage this gets more interesting. In the terminal
window where you are running the `watch` command you'll notice the message flash from
`I'm using canary deployments` to `Internal server error`.

![WatchCurlErrors](/images/code-pipeline-errors.gif)

After a few minutes you will see that CodeDeploy will mark this deployment as failed and roll back
to the previous version. The `Internal server error` messages will go away as all traffic is shifted
back to the previous version.

![CodeDeployProdError](/images/canary-deployment-prod-rollback.png)

Navigate to the [AWS CodeDeploy Console](https://console.aws.amazon.com/codedeploy/home) Deployments
page. Look at the Deployment which may be `In-Progress` or `Stopped`, depending on whether the
rollback is complete. Click on the Deployment Id to see its details.

You will see that CodeDeploy detected `CanaryErrorsAlarm` has triggered and stopped the deployment.

![CodeDeployRollback](/images/screenshot-codedeploy-rollback.png)

**Congratulations! You created a CI/CD pipeline which deploys a Lambda function using two different
strategies and automatically rolls back code when it detects errors.**
