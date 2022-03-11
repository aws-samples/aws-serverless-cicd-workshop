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

```javascript
response = {
  statusCode: 200,
  body: JSON.stringify({
    message: "I'm using canary deployments",
  }),
}
```

`~/environment/node-sam-app/hello-world/tests/unit/test-handler.js `

```javascript
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

```python
return {
    "statusCode": 200,
    "body": json.dumps({
        "message": "I'm using canary deployments",
    }),
}
```

`~/environment/sam-app/tests/unit/test_handler.py`

```python
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

First, get the HTTP endpoint of your dev stage. In a terminal on your Cloud9 enviroment run the
following command.

```bash
aws cloudformation describe-stacks --stack-name sam-app-dev  --query "Stacks[].Outputs[].[OutputKey,OutputValue]" --output table
```

```text
-----------------------------------------------------------------------------------------------------------------------------
|                                                      DescribeStacks                                                       |
+---------------------------+-----------------------------------------------------------------------------------------------+
|  HelloWorldFunctionIamRole|  arn:aws:iam::123456789012:role/sam-app-dev-HelloWorldFunctionRole-T01H28UIDIAP               |
|  HelloWorldApi            |  https://123123123.execute-api.us-east-2.amazonaws.com/Prod/hello/                           |
|  HelloWorldFunction       |  arn:aws:lambda:us-east-2:123456789012:function:sam-app-dev-HelloWorldFunction-YHGUbkNMLd4s   |
+---------------------------+-----------------------------------------------------------------------------------------------+
```

Copy the `HelloWorldApi` value and run the following command. This will hit your API endpoint every
second and print the return value to the screen and append it to the `outputs.txt` file. You can run
this from anywhere.

```bash
watch -n 1 "curl -s https://123123123.execute-api.us-east-2.amazonaws.com/Prod/hello/ | jq '.message' 2>&1 | tee -a outputs.txt"
```

You should see `Hello my friend` in the terminal and that message appended to the `outputs.txt`
file. Now that your script it logging API output turn your attendtion to your CodePipeline.

Wait for your pipeline to get to the `DeployTest`. Once you see it the blue `In Progress` status
navigate to the CodeDeploy.

![CanaryCodeDeploy](/images/screenshot-canary-codedeploy-00.png)

In the CodeDeploy console click on `Deployments`. You should see your deployment `In progress`. If
you do not see a deployment, click the refresh icon. Click on the Deployment to see the details.

![CanaryCodeDeploy](/images/screenshot-canary-codedeploy-0.png)

The deployment status shows that 10% of the traffic has been shifted to the new version (aka The
Canary). CodeDeploy will hold the remaining percentage until the specified time interval has
ellapsed, in this case we specified the interval to be 5 minutes.

![CanaryCodeDeploy](/images/screenshot-canary-codedeploy-1.png)

When you are in this stage, take a look at your terminal where you started the `watch` command. You
will see the message occasionally flash to `I'm using canary deployments`.

Shortly after the 5 minutes, the remaining traffic should be shifted to the new version:

![CanaryCodeDeploy](/images/screenshot-canary-codedeploy-2.png)

In the terminal where you ran the `watch` command, type `Ctrl-C` to stop. Count up the number of
messages to convince yourself that the traffic was shifted gradually.

```bash
sort outputs.txt  | uniq -c
```

Of course the ratio of new to old return messages depends on when you started and stopped the
`watch` command.

#### Now that canaries are enabled, let's setup automated rollbacks when your code throws errors.
