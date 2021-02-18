+++
title = "Initialize project"
date = 2019-10-02T14:22:32-07:00
weight = 5
+++

AWS SAM provides you with a command line tool, the AWS SAM CLI, that makes it easy for you to create and manage serverless applications. It particularly makes easy the scaffolding of a new project, as it creates the initial skeleton of a hello world application, so you can use it as a baseline and continue building your project from there. 

Run the following command to scaffold a new project:
```bash
sam init
```

It will prompt for project configuration parameters: 

#### Type `1` to select AWS Quick Start Templates
![samInit](/images/screenshot-sam-init-1.png)

#### Type `1` to select Zip as the package type
![samInit](/images/screenshot-sam-init-1.0.png)

#### Choose `nodejs12.x` for runtime
![samInit](/images/screenshot-sam-init-1.1.png)

#### Leave default `sam-app` for project name
![samInit](/images/screenshot-sam-init-2.png)

#### Type `1` to select the `Hello World Example`
![samInit](/images/screenshot-sam-init-5.png) 

{{% notice tip %}}
This command supports cookiecutter templates, so you could write your own custom scaffolding templates and specify them using the location flag, For example: sam init --location git+ssh://git@github.com/aws-samples/cookiecutter-aws-sam-python.git.
{{% /notice%}}

## Project should now be initialized

You should see a new folder `sam-app` created with a basic Hello World scaffolding.
![samInit](/images/screenshot-sam-init-7.png)

If you are interested in learning more about initializing SAM projects, you can find the full reference for the `sam init` command in the [SAM CLI reference](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-init.html).
