+++
title = "Update SAM template"
date = 2019-11-11T14:46:02-08:00
weight = 15
+++

Open the SAM template (`sam-app/template.yaml`) in your project and add the `AutoPublishAlias` and
`DeploymentPreference` blocks into the `HelloWorldFunction` properties section. The lines to add are
highlighted in the code block below. The line numbers are approximate and may not line up exactly
with your `template.yaml` file.

{{< tabs >}}
{{% tab name="Node" %}}

`~environment/sam-app/template.yaml`

```yaml {linenos=true,hl_lines=["2-4"],linenostart=20}
Runtime: nodejs16.x
AutoPublishAlias: live
DeploymentPreference:
  Type: Canary10Percent5Minutes
Architectures:
  - x86_64
```

{{% /tab %}}
{{% tab name="python" %}}

`~environment/sam-app/template.yaml`

```yaml {linenos=true,hl_lines=["2-4"],linenostart=20}
Runtime: python3.7
AutoPublishAlias: live
DeploymentPreference:
  Type: Canary10Percent5Minutes
Architectures:
  - x86_64
```

{{% /tab %}}
{{% /tabs %}}

### Deployment Preference Types

For this workshop, we are using the `Canary10Percent5Minutes` strategy, which means that traffic is
shifted in two increments. In the first increment, only 10% of the traffic is shifted to the new
Lambda version, and after 5 minutes, the remaining 90% is shifted. There are other deployment
strategies you can choose in CodeDeploy:

- `AllAtOnce`
- `Canary10Percent5Minutes`
- `Canary10Percent10Minutes`
- `Canary10Percent15Minutes`
- `Canary10Percent30Minutes`
- `Linear10PercentEvery1Minute`
- `Linear10PercentEvery2Minutes`
- `Linear10PercentEvery3Minutes`
- `Linear10PercentEvery10Minutes`

The `Linear` strategy means that traffic is shifted in batches every `X` minutes. For example,
`Linear10PercentEvery10Minutes` will shift an additional 10% of traffic every 10 minutes. The entire
deployment would then take approximately 10 minutes (more likely closer to 9 since the first batch is
shifted when the deployment begins).

### Validate the SAM template

Run the following command in your terminal:

```
cd ~/environment/sam-app
sam validate
```

If the template is correct, you will see `template.yaml is a valid SAM Template`. If you see an
error, then you likely have an indentation issue on the YAML file. Double check and make sure it
matches the screenshot shown above.

### Push the changes

In the terminal, run the following commands from the root directory of your `sam-app` project.

```
git add .
git commit -m "Add Canary deployment configuration to SAM"
git push
```

#### Next, we'll make a code change and see how CodeDeploy gradually shifts traffic.
