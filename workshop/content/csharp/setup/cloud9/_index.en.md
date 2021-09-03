+++
title = "Create a Cloud9 Workspace"
date = 2021-08-30T08:30:00-06:00
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

Once you navigate to the Cloud9 console, click on the **Create environment** button:
![CreateCloud9](/images/csharp/setup/cloud9_home_product.png)

Chose a name for your environment. For Example - **MyCloud9Workspace**
![ChoseNameCloud9](/images/csharp/setup/cloud9_create_envivronment.png)

Leave the default configuration, we don't need a heavy server for this workshop.  (If you are running in your personal account and has other projects with Cloud9, feel free to use a larger instance type.)  Click on the **Next Step** button.

![SpecsCloud9](/images/csharp/setup/cloud9_configure_settings.png)

Click on the **Create Environment** button.  After a couple of minutes, your environment should display a **Welcome** tab.

![FinishedCloud9](/images/csharp/setup/cloud9_ide_day_theme.png)

You can choose between a Day or Night theme by choosing the theme in the top menu: **View > Themes > Cloud9 > Cloud9 Day** or **Cloud9 Night**.

![DarkThemeCloud9](/images/csharp/setup/cloud9_ide_night_theme.png)