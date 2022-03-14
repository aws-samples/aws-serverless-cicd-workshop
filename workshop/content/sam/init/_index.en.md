+++
title = "Initialize project"
date = 2019-10-02T14:22:32-07:00
weight = 5
+++

AWS SAM provides you with a command line tool, the AWS SAM CLI, that makes it easy for you to create
and manage serverless applications. It particularly makes easy the scaffolding of a new project, as
it creates the initial skeleton of a hello world application, so you can use it as a baseline and
continue building your project from there.

Run the following command to scaffold a new project:

```bash
sam init
```

In the wizard, select `AWS QuickStart Templates` and `Hello World Example`. Do **not** use the
shortcut to use the latest Python version.

```text
Which template source would you like to use?
        1 - AWS Quick Start Templates
        2 - Custom Template Location
Choice: 1

Choose an AWS Quick Start application template
        1 - Hello World Example
        2 - Multi-step workflow
        3 - Serverless API
        4 - Scheduled task
        5 - Standalone function
        6 - Data processing
        7 - Infrastructure event management
        8 - Machine Learning
Template: 1

Use the most popular runtime and package type? (Python and zip) [y/N]: n
```

Next, select your preferred runtime and version. Make sure to select the correct version as shown below.

```text

Which runtime would you like to use?
        1 - dotnet6
        2 - dotnet5.0
        3 - dotnetcore3.1
        4 - go1.x
        5 - java11
        6 - java8.al2
        7 - java8
        8 - nodejs14.x
        9 - nodejs12.x
        10 - python3.9
        11 - python3.8
        12 - python3.7
        13 - python3.6
        14 - ruby2.7
```

- Node: `nodejs14.x`
- Python: `python3.7`
- Java: `python3.7`
- C#: `dotnet6`

Select `Zip` as the package type and leave `sam-app` as the `Project name`.

```text
What package type would you like to use?
        1 - Zip
        2 - Image
Package type: 1

Based on your selections, the only dependency manager available is pip.
We will proceed copying the template using pip.

Project name [sam-app]:
```

{{% notice tip %}}
This command supports cookiecutter templates, so you could write your own custom scaffolding
templates and specify them using the location flag.
For example: `sam init --location git+ssh://git@github.com/aws-samples/cookiecutter-aws-sam-python.git`
{{% /notice%}}

## Project should now be initialized

You should see a new folder `sam-app` created with a basic Hello World scaffolding.
![samInit](/images/screenshot-sam-init-7.png)

{{% notice note %}}
If you are interested in learning more about initializing SAM projects, you can find the full
reference for the `sam init` command in the
[SAM CLI reference](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-init.html).
{{% /notice %}}
