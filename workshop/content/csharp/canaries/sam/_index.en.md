+++
title = "Update SAM template"
date = 2019-11-11T14:46:02-08:00
weight = 15
+++

Open the SAM template (`sam-app/template.yaml`) in your project and add the following lines to the HelloWorldFunction `Properties` section after `Runtime`. 

```
AutoPublishAlias: live
DeploymentPreference:
    Type: Canary10Percent5Minutes
```

It should look like this:  
**PLEASE CHECK THE CORRECT INDENTATION, IT IS VERY IMPORTANT IN YAML FORMAT.**

![SamCanaryDeployment](/images/csharp/canaries/template_update.png)

### Deployment Preference Types

For this workshop, we are using the _Canary10Percent5Minutes_ strategy, which means that traffic is shifted in two increments. In the first increment, only 10% of the traffic is shifted to the new Lambda version, and after 5 minutes, the remaining 90% is shifted. There are other deployment strategies you can choose in CodeDeploy:

- Canary10Percent30Minutes
- Canary10Percent5Minutes
- Canary10Percent10Minutes
- Canary10Percent15Minutes
- Linear10PercentEvery10Minutes
- Linear10PercentEvery1Minute
- Linear10PercentEvery2Minutes
- Linear10PercentEvery3Minutes
- AllAtOnce

The _Linear_ strategy means that traffic is shifted in equal increments with an equal number of time interval between each increment.

### Validate the SAM template
Run the following command on your terminal: 

```bash
cd ~/environment/sam-app
sam validate
```

If the template is correct, you will see **template.yaml is a valid SAM Template**. If you see an error, then you likely have an indentation issue on the YAML file. Double check and make sure it matches the screenshot shown above.

### Push the changes

In the terminal, run the following commands from the root directory of your `sam-app` project.

```bash
git add .
git commit -m "Canary deployments with SAM"
git push
```