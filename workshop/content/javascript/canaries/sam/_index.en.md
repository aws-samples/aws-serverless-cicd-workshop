+++
title = "Update SAM template"
date = 2019-11-11T14:46:02-08:00
weight = 15
+++

Open the SAM template (`sam-app/template.yaml`) in your project and add the `AutoPublishAlias` and
`DeploymentPreference` blocks into the HelloWorldFunction properties section. The lines to add are
highlighted in the code block below. The line numbers are approximate and may not line up exactly
with your `template.yaml` file.

{{% notice warning %}}
The examples below are from a nodejs runtime. Add the `AutoPublishAlias` and
`DeploymentPreference` blocks but do **not** change the `Runtime` or anything else.
{{% /notice %}}

```yaml {linenos=true,hl_lines=["2-4"],linenostart=20}
Runtime: nodejs14.x
AutoPublishAlias: live
DeploymentPreference:
  Type: Canary10Percent5Minutes
Architectures:
  - x86_64
```

It should look similar to the screenshot below: **PLEASE CHECK THE CORRECT INDENTATION, IT IS VERY
IMPORTANT IN YAML FORMAT.**

![SamCanaryDeployment](/images/screenshot-canary-sam.png)

### Deployment Preference Types

For this workshop, we are using the _Canary10Percent5Minutes_ strategy, which means that traffic is
shifted in two increments. In the first increment, only 10% of the traffic is shifted to the new
Lambda version, and after 5 minutes, the remaining 90% is shifted. There are other deployment
strategies you can choose in CodeDeploy:

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

Run the following command in your terminal:

```
cd ~/environment/sam-app
sam validate
```

If the template is correct, you will see `template.yaml is a valid SAM Template`. If you see an
error, then you likely have an indentation issue on the YAML file. Double check and make sure it
matches the screenshot shown above.

### Make a code change

AWS SAM will not deploy anything when your code hasn't changed. Since our pipeline is using AWS SAM
as the deployment tool we need to make some changes to the application.

Change the message in your Lambda function's response code `"I'm using canary deployments"`.
Remember to update the unit tests too!

{{< tabs >}}
{{% tab name="Node" %}}

```javascript
response = {
  statusCode: 200,
  body: JSON.stringify({
    message: "I'm using canary deployments",
  }),
}
```

{{% /tab %}}

{{% tab name="python" %}}

```python
return {
    "statusCode": 200,
    "body": json.dumps({
        "message": "I'm using canary deployments",
    }),
}
```

{{% /tab %}}
{{< /tabs >}}

### Push the changes

In the terminal, run the following commands from the root directory of your `sam-app` project.

```
git add .
git commit -m "Canary deployments with SAM"
git push
```
