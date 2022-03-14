+++
title = "Deploy the app"
date = 2019-10-03T13:33:54-07:00
weight = 20
+++

The `sam deploy` command deploys your application by launching a CloudFormation stack. This command
has a guided interactive mode, which you enable by specifying the `--guided` parameter. It is
recommended to deploy with guided mode for the first time as it will capture the configuration for
future deployments.

Run the following command in the same directory level where the `template.yaml` is located:

```bash
sam deploy --guided
```

This will walk you through a series of questions. Your answers will be saved to a configuration file
at the end which will speed up future deployments. Pressing the `Enter` key will accept the default
value for each question which is displayed in brackets, for example `[sam-app]`. Letters in
UPPERCASE are defaults, for example, pressening enter to `[y/N]` will default in `No`.

{{% notice info %}}
Make sure to answer `y` to the question about missing authorization:
`HelloWorldFunction may not have authorization defined, Is this okay? [y/N]: y`
{{% /notice %}}

```text
Configuring SAM deploy
======================

   Looking for config file [samconfig.toml] :  Not found

   Setting default arguments for 'sam deploy'
   =========================================
   Stack Name [sam-app]:
   AWS Region [us-west-2]:
   #Shows you resources changes to be deployed and require a 'Y' to initiate deploy
   Confirm changes before deploy [y/N]:
   #SAM needs permission to be able to create roles to connect to the resources in your template
   Allow SAM CLI IAM role creation [Y/n]:
   #Preserves the state of previously provisioned resources when an operation fails
   Disable rollback [y/N]:
   HelloWorldFunction may not have authorization defined, Is this okay? [y/N]: y
   Save arguments to configuration file [Y/n]:
   SAM configuration file [samconfig.toml]:
   SAM configuration environment [default]:
```

### Deployment completed

This command might take a few minutes to finish because it is creating the resources (Lambda
function, API Gateway and IAM roles) on the AWS account. When it completes successfully, you should
see an output similar to the following:

```text
CloudFormation outputs from deployed stack
---------------------------------------------------------------------------------------------------------------------------
Outputs
---------------------------------------------------------------------------------------------------------------------------
Key                 HelloWorldFunctionIamRole
Description         Implicit IAM Role created for Hello World function
Value               arn:aws:iam::123456789123:role/sam-app-node-HelloWorldFunctionRole-1QWE9DKNCP6V3

Key                 HelloWorldApi
Description         API Gateway endpoint URL for Prod stage for Hello World function
Value               https://01111gpgpg.execute-api.us-west-2.amazonaws.com/Prod/hello/

Key                 HelloWorldFunction
Description         Hello World Lambda Function ARN
Value               arn:aws:lambda:us-west-2:123456789123:function:sam-app-node-HelloWorldFunction-5RxoDCiBWUPV
---------------------------------------------------------------------------------------------------------------------------
```

Note the output vlue for `HelloWorldApi`. The `Value` is the https enpoint for your new API Gateway.
You can load up this URL in your browser or `curl` it in a terminal.

```bash
curl -s https://01111gpgpg.execute-api.us-west-2.amazonaws.com/Prod/hello/

{"message":"hello my friend"}
```

### What just happened?

The guided deployment does few things for you. Let's take a quick look at what happened under the hood during the guided deployment to understand this process better.

1. Your codebase gets packaged in a zip file.
1. SAM creates an S3 bucket in your account, if it doesn't already exist.
1. Zip file is uploaded to the S3 bucket.
1. SAM creates the [packaged template](/javascript/manualdeploy/bucket.html#the-packaged-template)
   that references the location of the zip file on S3.
1. This template is also uploaded to the S3 bucket.
1. SAM starts the deployment via CloudFormation ChangeSets.

The first time you do a guided deployment, a new file `samconfig.toml` is created in the root of
your project with your specified deployment parameters. This file speeds up future
`sam deploy` by using the same parameters without having you to enter them again.

```toml
version = 0.1
[default]
[default.deploy]
[default.deploy.parameters]
stack_name = "sam-app"
s3_bucket = "aws-sam-cli-managed-default-samclisourcebucket-3ma345ba4af33"
s3_prefix = "sam-app"
region = "us-west-2"
capabilities = "CAPABILITY_IAM"
image_repositories = []
```

If you want to learn more about guided deployments and the samconfig.toml file, here is a good Blog
Post: https://aws.amazon.com/blogs/compute/a-simpler-deployment-experience-with-aws-sam-cli.
