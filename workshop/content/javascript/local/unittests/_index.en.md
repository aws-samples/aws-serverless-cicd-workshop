+++
title = "Run the unit tests"
date = 2019-10-03T09:05:09-07:00
weight = 20
+++

Running the unit tests locally is no different for Serverless applications. Developers run them
before pushing changes to a code repository. Let's look at how to run tests in our application.

In your terminal, run these commands to execute the unit tests:

{{< tabs >}}
{{% tab name="Node" %}}

```bash
cd ~/environment/sam-app/hello-world
npm install
npm run test
```

{{% /tab %}}
{{% tab name="python" %}}

```bash
cd ~/environment/sam-app
pip3 install pytest pytest-mock
python3 -m pytest tests/unit
```

{{% /tab %}}
{{% /tabs %}}

Don't worry! The tests will fail which is expected.

{{< tabs >}}
{{% tab name="Node" %}}

```text
  1) Tests index
       verifies successful response:

      AssertionError: expected 'hello my friend' to equal 'hello world'
      + expected - actual

      -hello my friend
      +hello world
```

{{% /tab %}}
{{% tab name="python" %}}

```text
    def test_lambda_handler(apigw_event, mocker):

        ret = app.lambda_handler(apigw_event, "")
        data = json.loads(ret["body"])

        assert ret["statusCode"] == 200
        assert "message" in ret["body"]
>       assert data["message"] == "hello world"
E       AssertionError: assert 'hello my friend' == 'hello world'
E         - hello world
E         + hello my friend

tests/unit/test_handler.py:72: AssertionError
```

{{% /tab %}}
{{% /tabs %}}

{{% notice note %}}
This project uses the [Chai Framework](https://www.chaijs.com) or [Pytest](https://pytest.org/) for
running unit tests. You can use any framework of your choice. SAM does not enforce frameworks on you.
You can use a unit testing workflow that works for you and that you may use in a non-serverless
application.
{{% /notice%}}

### Fix the unit test

Makes sense right? We changed the response message to `hello my friend` and the unit test was
expecting `hello world`. This is an easy fix, let's update the unit test.

{{< tabs >}}
{{% tab name="Node" %}}

`hello-world/tests/unit/test-handler.js`

```js {hl_lines=["12"]}
describe("Tests index", function () {
  it("verifies successful response", async () => {
    const result = await app.lambdaHandler(event, context)

    expect(result).to.be.an("object")
    expect(result.statusCode).to.equal(200)
    expect(result.body).to.be.an("string")

    let response = JSON.parse(result.body)

    expect(response).to.be.an("object")
    expect(response.message).to.be.equal("hello my friend")
  })
})
```

{{% /tab %}}
{{% tab name="python" %}}

`tests/unit/test_handler.py`

```python {hl_lines=["8"]}
def test_lambda_handler(apigw_event, mocker):

    ret = app.lambda_handler(apigw_event, "")
    data = json.loads(ret["body"])

    assert ret["statusCode"] == 200
    assert "message" in ret["body"]
    assert data["message"] == "hello my friend"
```

{{% /tab %}}
{{% /tabs %}}

### Run the tests again

{{< tabs >}}
{{% tab name="Node" %}}

```text
npm run test

  Tests index
    ✔ verifies successful response


  1 passing (6ms)
```

{{% /tab %}}
{{% tab name="python" %}}

```text
python3 -m pytest tests/unit

tests/unit/test_handler.py .                                                                                                                        [100%]
========= 1 passed in 0.02s ========
```

{{% /tab %}}
{{% /tabs %}}
