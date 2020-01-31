+++
title = "Make a code change"
date = 2019-10-03T08:52:21-07:00
weight = 15
+++

While the app is still running, open the file `sam-app/hello-world/app.js` and make a simple code change. For example, change the response message to return `hello my friend` instead of _hello world_. Your Lambda handler should look like this after the change: 

![MakeCodeChange](/images/screenshot-make-code-change.png)

**Note: Make sure you save the file after changing it.**

You don't have to restart the `sam local` process, just refresh the browser tab or re-trigger the CURL command to see the changes reflected in your endpoint.
![SamLocalCodeChange](/images/screenshot-samlocal-code-change.png)

{{% notice tip %}}
You only need to restart `sam local` if you change the `template.yaml`.
{{% /notice%}}
