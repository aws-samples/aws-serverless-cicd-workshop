+++
title = "Create a Cloud9 Workspace"
date = 2019-10-02T10:56:08-07:00
weight = 5
+++

{{% notice tip %}}
Ad blockers, javascript disablers, and tracking blockers should be disabled for
the cloud9 domain, or connecting to the workspace might be impacted.
Cloud9 requires third-party-cookies. You can whitelist the [specific domains]( https://docs.aws.amazon.com/cloud9/latest/user-guide/troubleshooting.html#troubleshooting-env-loading).
{{% /notice %}}

### Navigate to the Cloud9 console:

Navigate to the Cloud9 console: [https://console.aws.amazon.com/cloud9](https://console.aws.amazon.com/cloud9)

### Create a workspace

Once you navigate to the Cloud9 console, click on the create environment button:
![CreateCloud9](/images/screenshot-cloud9-1.png)

Chose a name for your environment. For Example - **MyCloud9Workspace**
![ChoseNameCloud9](/images/screenshot-cloud9-2.png)

Leave the default configuration, we don't need a heavy server for this workshop.                                
(If you are running in your personal account and has other projects with Cloud9, feel free to use a larger instance type.)

![SpecsCloud9](/images/screenshot-cloud9-3.png)

Once you confirm creation, after a couple of minutes, your environment should look like the following image:
![FinishedCloud9](/images/screenshot-cloud9-4.png)

**(Optional)** If you prefer a dark theme, chose the theme in the top menu: **View > Themes > Cloud9 > Cloud 9 Night**.
![DarkThemeCloud9](/images/screenshot-cloud9-5.png)