+++
title = "Make a code change"
date = 2019-10-03T08:52:21-07:00
weight = 15
+++

While the app is still running, open the application code and make a
simple change. Change the response message to return `hello my friend` instead of
`hello world`. Your Lambda handler should look like this after the change:

{{< tabs >}}
{{% tab name="Node" %}}

`~environment/sam-app/hello-world/app.js`

```js {hl_lines=["8"]}
let response

exports.lambdaHandler = async (event, context) => {
  try {
    response = {
      statusCode: 200,
      body: JSON.stringify({
        message: "hello my friend",
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
`~environment/sam-app/hello_world/app.py`

```python {hl_lines=["7"]}
import json

def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "hello my friend",
        }),
    }
```

{{% /tab %}}
{{% /tabs %}}

You do **not** need to restart the `sam local` process. You **do** need to save your application
code file!

Hit your `localhost:8080/hello` endpoint again and you will see the updated message:
`{"message": "hello my friend"}`. If you don't see the updated code double check that you have saved
your `app.js` or `app.py` file.

```
curl http://localhost:8080/hello
{"message": "hello my friend"}
```
