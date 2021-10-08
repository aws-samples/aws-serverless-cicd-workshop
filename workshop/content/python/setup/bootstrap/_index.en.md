+++
title = "Upgrade SAM CLI"
date = 2019-10-16T16:29:54-07:00
weight = 10
+++

One of the tools this workshop relies on, is the AWS SAM Command Line Interface. However, we need a newer version than what Cloud9 has pre-installed. The version we are targetting is **SAM CLI, version 1.29.0 or greater**.

### Bootstrap Script

We have put together a bootstrap script that will make the upgrade easier for you. Download it by running the following command from your Cloud9 terminal. 

```bash
wget https://cicd.serverlessworkshops.io/assets/bootstrap.sh
```

Then give it permissions to execute: 

```bash
chmod +x bootstrap.sh
```

And run it: 

```bash
./bootstrap.sh
```

**THIS MAY TAKE A FEW MINUTES TO COMPLETE.**

### Verify the new version

Run the following command: 

```bash
sam --version
```

You should see *SAM CLI, version 1.29.0* or greater.

![BootstrapScreenshot](/images/python/setup/cloud9_ide_bootstrap.png)