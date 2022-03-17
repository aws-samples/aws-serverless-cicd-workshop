+++
title = "Gradually deploy an update"
date = 2019-11-11T16:01:01-08:00
weight = 20
+++

Our Pipeline is setup to deploy new code using the `Canary10Percent5Minutes` strategy. To see this
in action we need to push an update to our application.

### Make a code change

AWS SAM will not deploy anything when your code hasn't changed. Since our pipeline is using AWS SAM
as the deployment tool we need to make some changes to the application.

Change the message in your Lambda function's response code `"I'm using canary deployments"`.
Remember to update the unit tests!

{{< tabs >}}
{{% tab name="Node" %}}

`~/environment/sam-app/hello-world/app.js`

```javascript {hl_lines=["4"]}
response = {
  statusCode: 200,
  body: JSON.stringify({
    message: "I'm using canary deployments",
  }),
}
```

`~/environment/node-sam-app/hello-world/tests/unit/test-handler.js `

```javascript {hl_lines=["12"]}
describe("Tests index", function () {
  it("verifies successful response", async () => {
    const result = await app.lambdaHandler(event, context)

    expect(result).to.be.an("object")
    expect(result.statusCode).to.equal(200)
    expect(result.body).to.be.an("string")

    let response = JSON.parse(result.body)

    expect(response).to.be.an("object")
    expect(response.message).to.be.equal("I'm using canary deployments")
  })
})
```

{{% /tab %}}

{{% tab name="python" %}}

`~/environment/sam-app/hello_world/app.py `

```python {hl_lines=["4"]}
return {
    "statusCode": 200,
    "body": json.dumps({
        "message": "I'm using canary deployments",
    }),
}
```

`~/environment/sam-app/tests/unit/test_handler.py`

```python {hl_lines=["7"]}
def test_lambda_handler(apigw_event, mocker):
    ret = app.lambda_handler(apigw_event, "")
    data = json.loads(ret["body"])

    assert ret["statusCode"] == 200
    assert "message" in ret["body"]
    assert data["message"] == "I'm using canary deployments"
```

{{% /tab %}}
{{< /tabs >}}

### Push the code

```
git add .
git commit -m "Changed return message"
git push
```

### Watch the canary

It will take a few minutes for your pipeline to get to the `DeployTest` stage which will start the
canary deployment of the stage you named `sam-app-dev`. Start up a watcher which will output your
API's message every second. By doing this you will notice when traffic shifting starts and
completes.

First, get the `https` endpoint of your dev stage. In a terminal on your Cloud9 enviroment run the
following command.

{{%expand "Export the HTTP endpoints if you haven't already" %}}

```bash
export DEV_ENDPOINT=$(aws cloudformation describe-stacks --stack-name sam-app-dev | jq -r '.Stacks[].Outputs[].OutputValue | select(startswith("https://"))')
export PROD_ENDPOINT=$(aws cloudformation describe-stacks --stack-name sam-app-prod | jq -r '.Stacks[].Outputs[].OutputValue | select(startswith("https://"))')
```

{{% /expand%}}

Hit your `dev` API endpoint every second and print the return value to the screen. This command will
also append the output to the `outputs.txt` file that you can inspect later. You can run this
command from any directory.

```bash
watch -n 1 "curl -s $DEV_ENDPOINT | jq '.message' 2>&1 | tee -a outputs.txt"
```

You should see `Hello my friend` in the terminal. Now that your script is logging the API output turn
your attendtion to your CodePipeline.

Wait for your pipeline to get to the `DeployTest` stage. Once you see it turn blue with
the `In Progress` status navigate to the CodeDeploy console.

![CanaryCodeDeploy](/images/screenshot-canary-codedeploy-00.png)

In the CodeDeploy console click on `Deployments`. You should see your deployment `In progress`. If
you do not see a deployment, click the refresh icon. **This may take a few minutes to show up!**
Click on the Deployment Id to see the details.

![CanaryCodeDeploy](/images/screenshot-canary-codedeploy-0.png)

The deployment status shows that 10% of the traffic has been shifted to the new version (the
Canary). CodeDeploy will hold the remaining percentage until the specified time interval has
ellapsed. In this case we specified the interval to be 5 minutes.

![CanaryCodeDeploy](/images/screenshot-canary-codedeploy-1.png)

When you are in this stage, take a look at your terminal where you started the `watch` command. You
will see the message occasionally flash to `I'm using canary deployments`.

![CanaryDeploymentMessages](/images/code-pipeline-canary.gif)

After five minutes CodeDeploy will shift the remaining traffic to the new version and the deployment
will be done:

![CanaryCodeDeploy](/images/screenshot-canary-codedeploy-2.png)

In the terminal where you ran the `watch` command, type `Ctrl-C` to stop. Count up the number of
messages for each `message` string to validate the traffic was shifted gradually. Of course the
ratio of new to old return messages depends on when you started and stopped the `watch` command.

```bash
sort outputs.txt  | uniq -c
228 "hello my friend"
 84 "I'm using canary deployments"
```

You can also see the sequence of return values by opening `outputs.txt`.

```bash
cat outputs.txt
```

#### Now that canaries are enabled, let's setup automated rollbacks when your code throws errors.
