+++
title = "Make a code change"
date = 2021-08-30T08:30:00-06:00
weight = 15
+++

While the app is still running, open the file `sam-app/HelloWorld/Function.cs` and make a simple code change. For example, change the response message to return **hello my friend** instead of **hello world**. Your Lambda handler should look like this after the change: 

![MakeCodeChange](/images/csharp/local/cloud9_ide_code_change.png)

**Note: Make sure you save the file after changing it.**

Because C# is a compiled language, you need to Ctrl-C to stop the `sam local` process, re-build, and restart the `sam local` process.

```bash
sam build
sam local start-api --port 8080
```

Refresh the browser tab or re-trigger the `curl` command to see the changes reflected in your endpoint.
![SamLocalCodeChange](/images/csharp/local/cloud9_ide_browser_change.png)

