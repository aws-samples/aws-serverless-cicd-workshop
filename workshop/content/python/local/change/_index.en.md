+++
title = "Make a code change"
date = 2021-08-30T08:30:00-06:00
weight = 15
+++

While the app is still running, open the file `sam-app/hello_world/app.py` and make a simple code change. For example, change the response message to return **hello my friend** instead of **hello world**. Your Lambda handler should look like this after the change: 

![MakeCodeChange](/images/python/local/cloud9_ide_code_change.png)

**Note: Make sure you save the file after changing it.**

You don't have to restart the `sam local` process, just refresh the browser tab or re-trigger the `curl` command to see the changes reflected in your endpoint.
![SamLocalCodeChange](/images/python/local/cloud9_ide_browser_change.png)

{{% notice tip %}}
You only need to restart `sam local` if you change the `template.yaml`.
{{% /notice%}}
