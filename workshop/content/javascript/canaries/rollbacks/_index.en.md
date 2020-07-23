+++
title = "Rollbacks"
date = 2019-11-12T08:00:36-08:00
weight = 30
+++

Monitoring the health of your canary allows CodeDeploy to make a decision to whether a rollback is needed or not. If any of the CloudWatch Alarms specified gets to ALARM status, CodeDeploy rollsback the deployment automatically. 

### Introduce an error on purpose

Lets break the Lambda function on purpose so that the _CanaryErrorsAlarm_ gets triggered during deployment. Update the lambda code in `sam-app/hello-world/app.js` to throw an error on every invocation, like this:

```
let response;

exports.lambdaHandler = async (event, context) => {
    throw new Error("This will cause a deployment rollback");
    // try {
    //     response = {
    //         'statusCode': 200,
    //         'body': JSON.stringify({
    //             message: 'hello my friend with canaries',
    //         })
    //     }
    // } catch (err) {
    //     console.log(err);
    //     return err;
    // }

    // return response
};
```

Make sure to update the unit test, otherwise the build will fail. Comment out every line in the `sam-app/hello-world/tests/unit/test-handler.js` file: 

```
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

### Push the changes

In the terminal, run the following commands from the root directory of your `sam-app` project.

```
git add .
git commit -m "Breaking the lambda function on purpose"
git push
```