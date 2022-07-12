+++
title = "Run using SAM CLI"
date = 2019-10-02T16:36:58-07:00
weight = 10
+++

There are 2 ways of running a Serverless app locally:

1. By invoking an individual Lambda function
2. By running a local HTTP server that simulates API Gateway

In this workshop, we will focus on number 2, but you can learn about invoking individual functions in the
[SAM Local Invoke reference](https://docs.aws.amazon.com/en_pv/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-local-invoke.html).

{{< tabs >}}
{{% tab name="Node" %}}

```bash
cd ~/environment/sam-app
sam local start-api --port 8080
```

{{% /tab %}}
{{% tab name="python" %}}

```bash
cd ~/environment/sam-app
sam local start-api --port 8080
```

{{% /tab %}}
{{% /tabs %}}

{{% notice note %}}
In a Cloud9 workspace, you must use port `8080`, `8081` or `8082` to be able to open the URL in the local browser for preview.
{{% /notice %}}

### Test your endpoint

Once your local server is running, we can send HTTP requests to test it. Chose one of the following options:

{{% notice note %}}
The first request will take several seconds as SAM downloads a Docker image. Continue reading to
learn why SAM does this.
{{% /notice %}}

#### Option A) Using CURL

Without killing the running process, open a new terminal.

![OpenNewTerminal](/images/screenshot-new-terminal.png)

Test your endpoint by running a CURL command that triggers an HTTP GET request.

```
curl http://localhost:8080/hello
```

#### Option B) Using a browser window

In Cloud9, go to the top menu and chose **Tools > Preview > Preview Running Application**. A browser
tab will open, append `/hello` to the end of the URL. This will invoke your Lambda function locally.

![PreviewSamLocal](/images/screenshot-samlocal-preview.png)

Note how SAM is pulling a Docker container image. This is how SAM is able to simulate the Lambda
runtime locally and run your function. The first invocation might take a few seconds due to the
`docker pull` command, but subsequent invocations will be faster. SAM will pull the appropriate
container based on the runtime you have configured in `template.yaml`
