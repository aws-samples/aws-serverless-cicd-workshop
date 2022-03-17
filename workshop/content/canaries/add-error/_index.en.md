+++
title = "Introduce an error"
date = 2019-11-12T08:00:36-08:00
weight = 30
+++

Monitoring the health of your canary allows CodeDeploy to make a decision to whether a rollback is
needed. If our CloudWatch Alarm gets to `ALARM` status, CodeDeploy will roll
back the deployment automatically.

### Introduce an error on purpose

Lets break the Lambda function on purpose so that the `CanaryErrorsAlarm` is triggered during
deployment. Update the Lambda code to throw an error on every invocation. Make sure to update the
unit test otherwise the build will fail.

{{< tabs >}}
{{% tab name="Node" %}}

`~/environment/sam-app/hello-world/app.js`

```javascript
let response

exports.lambdaHandler = async (event, context) => {
  throw new Error("This will cause a deployment rollback")
  // try {
  //     response = {
  //         "statusCode": 200,
  //         "body": JSON.stringify({
  //             message: "I'm using canary deployments",
  //         })
  //     }
  // } catch (err) {
  //     console.log(err);
  //     return err;
  // }

  // return response
}
```

`~/environment/node-sam-app/hello-world/tests/unit/test-handler.js`

```javascript
// 'use strict';

// const app = require('../../app.js');
// const chai = require('chai');
// const expect = chai.expect;
// var event, context;

// describe('Tests index', function () {
//     it('verifies successful response', async () => {
//         const result = await app.lambdaHandler(event, context)

//         expect(result).to.be.an('object');
//         expect(result.statusCode).to.equal(200);
//         expect(result.body).to.be.an('string');

//         let response = JSON.parse(result.body);

//         expect(response).to.be.an('object');
//         expect(response.message).to.be.equal("hello my friend with canaries");
//     });
// });
```

{{% /tab %}}
{{% tab name="python" %}}

`~/environment/sam-app/hello_world/app.py`

```python {hl_lines=["3-4"]}
def lambda_handler(event, context):

    if True:
        raise Exception("This will cause a deployment rollback")

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
    assert True
```

{{% /tab %}}
{{< /tabs >}}

### Push the changes

In the terminal, run the following commands from the root directory of your `sam-app` project.

```
cd ~/environment/sam-app
git add .
git commit -m "Breaking the lambda function on purpose"
git push
```

### Generate traffic

Once you've pushed the code you will need to generate traffic on your production API Gateway
endpoint. **If you don't generate traffic for your Lambda function the CloudWatch alarm will not be
triggered!**

{{%expand "If you haven't exported the PROD_ENDPOINT, run the following command." %}}

```bash
export PROD_ENDPOINT=$(aws cloudformation describe-stacks --stack-name sam-app-prod | jq -r '.Stacks[].Outputs[].OutputValue | select(startswith("https://"))')
echo "$PROD_ENDPOINT"
```

{{% /expand%}}

Start a `watch` command which will hit this endpoint twice per second.

```bash
watch -n 0.5 "curl -s $PROD_ENDPOINT"
```

#### Now that you have pushed some bad code let's watch CodeDeploy stop the deployment.
