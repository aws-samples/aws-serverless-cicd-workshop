+++
title = "Build the app"
date = 2021-08-30T08:30:00-06:00
weight = 10
+++

To build a SAM project, we are going to use the `sam build` command. This command iterates through the functions in your application, looking for the manifest file (such as requirements.txt or package.json) that contains the dependencies, and automatically creates deployment artifacts.

From the root of the `sam-app` folder, run the following command in the terminal:

```bash
cd ~/environment/sam-app
sam build
```

<!--
{{% notice warning %}}
Error: Template file not found at */template.yaml.  
If you got this error is because you need to run SAM commands at the same level where the _template.yaml_ file is located.
{{% /notice%}}
-->

### Build completed
When the build finishes successfully, you should see a new directory created in the root of the project named `.aws-sam`. It is a hidden folder, so if you want to see it in the IDE, **make sure you enable _Show Hidden Files_ in Cloud9** to see it. 
![SamBuild](/images/csharp/manualdeploy/cloud9_ide_sam_build.png)

### Explore the build folder
Take a moment to explore the contents of the `.aws-sam/build` folder. 