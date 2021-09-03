+++
title = "Install dependencies"
date = 2021-08-30T08:30:00-06:00
weight = 5
+++

Before we run the application locally, it's a common practice to install third-party libraries or dependencies that your application might be using. These dependencies are defined in a file that varies depending on the runtime, for example _package.json_ for Node.js projects or _requirements.txt_ for Python ones. 

In the terminal, go into the `sam-app/src/HelloWorld` folder and install the dependencies:

```bash
cd ~/environment/sam-app/src/HelloWorld
dotnet restore
```

Example: 

![pip install](/images/csharp/local/cloud9_ide_dotnet_restore.png)