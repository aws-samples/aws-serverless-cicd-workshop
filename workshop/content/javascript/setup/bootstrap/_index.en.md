+++
title = "Upgrade SAM CLI"
date = 2019-10-16T16:29:54-07:00
weight = 10
+++

One of the tools this workshop relies on, is the AWS SAM Command Line Interface. However, we need a newer version than what Cloud9 has pre-installed. The version we are targetting is **SAM CLI, version 0.31.1 or greater**.

### Bootstrap Script

We have put together a bootstrap script that will make the upgrade easier for you. Download and run
it using the following command from your Cloud9 terminal.

```
curl -s https://cicd.serverlessworkshops.io/assets/bootstrap.sh | bash
```

**THIS MAY TAKE A FEW MINUTES TO COMPLETE.**


Example output:

**TODO -- update this screenshot**

![BootstrapScreenshot](/images/screenshot-bootstrap.png)

### Verify the new version

Run the following command:

```
sam --version
```

You should see _SAM CLI, version 1.31.0_ or greater.
