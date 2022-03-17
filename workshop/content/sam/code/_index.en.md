+++
title = "Explore the Lambda code"
date = 2019-10-02T15:21:26-07:00
weight = 15
+++

Let's take a look at the code of the Hello World Lambda function.

{{% notice note %}}
Your function may have additional comments. Those lines have been removed from the following example
for clarity.
{{% /notice%}}

{{< tabs >}}
{{% tab name="Node" %}}

`hello-world/app.js`

```js
let response

exports.lambdaHandler = async (event, context) => {
  try {
    response = {
      statusCode: 200,
      body: JSON.stringify({
        message: "hello world",
      }),
    }
  } catch (err) {
    console.log(err)
    return err
  }

  return response
}
```

{{% /tab %}}

{{% tab name="python" %}}

`hello_world/app.py`

```python
import json

def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "hello world",
        }),
    }

```

{{% /tab %}}

{{< /tabs >}}

### The Lambda handler

The handler is the method in your Lambda function that processes events. When you invoke a function,
the runtime runs the handler method. When your function exits or returns a response, it becomes
available to handle another event. You can change the name or location of your handler function via
the `CodeUri` and `Handler` keys in the SAM `template.yaml` file.

{{% notice tip %}}
Because the Lambda handler is executed on every invocation, a best practice is to place code that
can be reused across invocations outside of the handler scope. A common example is to initialize
database connections outside of the handler.
{{% /notice%}}

#### Event object

The first argument passed to the handler function is the `event` object, which contains information
from the invoker. In this case, the invoker is API Gateway, which passes the HTTP request
information as a JSON-formatted string, and the Lambda runtime converts it to an object. You can
find examples of event payloads here:
[https://docs.aws.amazon.com/lambda/latest/dg/lambda-services.html](https://docs.aws.amazon.com/lambda/latest/dg/lambda-services.html)

#### Context object

The second argument is the context object, which contains information about the invocation,
function, and execution environment. You can get information like the CloudWatch log stream name or
the remaining execution time for the function.

#### Handler Response

API Gateway expects the handler to return a response object that contains `statusCode` and `body`,
but it can also contain optional `headers`. You can read more about the response format in the
[Lambda with API Gateway integration documentation](https://docs.aws.amazon.com/lambda/latest/dg/services-apigateway.html#apigateway-types-transforms).
