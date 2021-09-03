+++
title = "Run the unit tests"
date = 2021-08-30T08:30:00-06:00
weight = 20
+++

As you typically would, with any software project, running the unit tests locally is no different for Serverless applications. Developers run them before pushing changes to a code repository. So, go ahead and run the unit tests for your project.

{{% notice note %}}
This project uses the [xUnit.net framework](https://xunit.net/) for running the unit tests, but you can chose any other framework. SAM doesn't enforce any particular one. You can continue to have the same unit testing workflow that you do in a non-serverless application.
{{% /notice%}}

In the terminal, run this command from the `sam-app/test/HelloWorld.Test` folder to run the unit tests:

```bash
cd ~/environment/sam-app/test/HelloWorld.Test
dotnet restore
dotnet test
```

The tests should fail. This is expected!

![FailedUnitTests](/images/csharp/local/cloud9_ide_xunit_fail.png)

### Fix the unit test
Makes sense right? We changed the response message to **hello my friend** and the unit test was expecting **hello world**. This is an easy fix, let's update the unit test. 

Open the file `sam-app/test/HelloWorld.Test/FunctionTests.cs` and update the expected value for the response to match the new message. The unit test should look like this after the update:

```csharp
    [Fact]
    public async Task TestHelloWorldFunctionHandler()
    {
            var request = new APIGatewayProxyRequest();
            var context = new TestLambdaContext();
            string location = GetCallingIP().Result;
            Dictionary<string, string> body = new Dictionary<string, string>
            {
                { "message", "hello my friend" },
                { "location", location },
            };

            var expectedResponse = new APIGatewayProxyResponse
            {
                Body = JsonConvert.SerializeObject(body),
                StatusCode = 200,
                Headers = new Dictionary<string, string> { { "Content-Type", "application/json" } }
            };

            var function = new Function();
            var response = await function.FunctionHandler(request, context);

            Console.WriteLine("Lambda Response: \n" + response.Body);
            Console.WriteLine("Expected Response: \n" + expectedResponse.Body);

            Assert.Equal(expectedResponse.Body, response.Body);
            Assert.Equal(expectedResponse.Headers, response.Headers);
            Assert.Equal(expectedResponse.StatusCode, response.StatusCode);
    }

```

### Run the tests again
Run the same command again.

```bash
dotnet test
```

Now the tests should pass:
![UnitTestsSucceed](/images/csharp/local/cloud9_ide_xunit_pass.png)

