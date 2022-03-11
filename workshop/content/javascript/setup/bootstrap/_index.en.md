+++
title = "Upgrade SAM CLI"
date = 2019-10-16T16:29:54-07:00
weight = 10
+++

The primary tool this workshop relies on is the [AWS Serverless Application Model (SAM)](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html). However, we
need a newer version than what Cloud9 has pre-installed. The version we are targetting is **SAM CLI,
version 1.33.0 or greater**.

### Bootstrap Script

We have put together a bootstrap script that will make the upgrade easier for you. Download and run
it using the following command from your Cloud9 terminal.

```
curl -s https://cicd.serverlessworkshops.io/assets/bootstrap.sh | bash
```

**THIS MAY TAKE A FEW MINUTES TO COMPLETE.**

There will be a lot of text output as the script updates system packages, the `aws-cli` and
`aws-sam`. At the end you should see output which looks similar to below.

![BootstrapScreenshot](/images/screenshot-bootstrap.png)

### Verify the new version

{{% notice note %}}
Verify that you have AWS SAM version 1.40.0 or greater installed.
{{% /notice %}}

```terminal
sam --version
```

If you see anything less than `1.40.0`, stop and ensure the `bootstrap.sh` script completed successfully.
