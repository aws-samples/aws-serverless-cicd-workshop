+++
title = "Run the unit tests"
date = 2021-08-30T08:30:00-06:00
weight = 20
+++

As you typically would, with any software project, running the unit tests locally is no different for Serverless applications. Developers run them before pushing changes to a code repository. So, go ahead and run the unit tests for your project.

Open `sam-app/tests/unit/test_hander.py` and change the `test_lambda_handler` function signature (you may need to remove `mocker` parameter)

```python
def test_lambda_handler(apigw_event):
```

After the change, `test_lambda_handler` should look like this:

![TestHandler](/images/python/sam/cloud9_ide_test_handler.png)

{{% notice note %}}
This project uses the [pytest framework](https://docs.pytest.org/) for running the unit tests, but you can chose any other framework. SAM doesn't enforce any particular one. You can continue to have the same unit testing workflow that you do in a non-serverless application.
{{% /notice%}}

In the terminal, run this command from the `sam-app/hello_world` folder to run the unit tests:

```bash
cd ~/environment/sam-app
pip3 install pytest
python3 -m pytest tests/unit
```

The tests should fail. This is expected!

![FailedUnitTests](/images/python/sam/cloud9_ide_pytest_fail.png)

### Fix the unit test
Makes sense right? We changed the response message to **hello my friend** and the unit test was expecting **hello world**. This is an easy fix, let's update the unit test. 

Open the file `sam-app/tests/unit/test_handler.py` and update the expected value for the response to match the new message. The unit test should look like this after the update:

```python
import json
import pytest

from hello_world import app


@pytest.fixture()
def apigw_event():
    """ Generates API GW Event"""

    return {
        # API Gateway Event here
    }

def test_lambda_handler(apigw_event):

    ret = app.lambda_handler(apigw_event, "")
    data = json.loads(ret["body"])

    assert ret["statusCode"] == 200
    assert "message" in ret["body"]
    assert data["message"] == "hello my friend" # <- FIX
    # assert "location" in data.dict_keys()
```

### Run the tests again
Run the same command again.

```bash
python3 -m pytest tests/unit
```

Now the tests should pass:
![UnitTestsSucceed](/images/python/sam/cloud9_ide_pytest_pass.png)

