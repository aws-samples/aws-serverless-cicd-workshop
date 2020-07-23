+++
title = "Run the unit tests"
date = 2019-10-03T09:05:09-07:00
weight = 20
+++

As you typically would, with any software project, running the unit tests locally is no different for Serverless applications. Developers run them before pushing changes to a code repository. So, go ahead and run the unit tests for your project.

In the terminal, run this command from the `sam-app/hello-world` folder to run the unit tests:

```
cd ~/environment/sam-app/hello-world
npm run test
```

The tests should fail. This is expected!

![FailedUnitTests](/images/screenshot-unit-tests-fail.png)

### Fix the unit test
Makes sense right? We changed the response message to **hello my friend** and the unit test was expecting **hello world**. This is an easy fix, let's update the unit test. 

Open the file `sam-app/hello-world/tests/unit/test-handler.js` and update the expected value for the response to match the new message. The unit test should look like this after the update:

```
'use strict';

const app = require('../../app.js');
const chai = require('chai');
const expect = chai.expect;
var event, context;

describe('Tests index', function () {
    it('verifies successful response', async () => {
        const result = await app.lambdaHandler(event, context)

        expect(result).to.be.an('object');
        expect(result.statusCode).to.equal(200);
        expect(result.body).to.be.an('string');

        let response = JSON.parse(result.body);

        expect(response).to.be.an('object');
        expect(response.message).to.be.equal("hello my friend"); // <- FIX
    });
});
```

### Run the tests again
Run the same command again.

```
npm run test
```

Now the tests should pass:
![UnitTestsSucceed](/images/screenshot-unit-tests-succeed.png)

{{% notice note %}}
This project uses the [Chai Framework](https://www.chaijs.com) for running the unit tests, but you can chose any other framework. SAM doesn't enforce any particular one. You can continue to have the same unit testing workflow that you do in a non-serverless application.
{{% /notice%}}