+++
title = "Initialize project"
date = 2021-08-30T08:30:00-06:00
weight = 5
+++

AWS SAM provides you with a command line tool, the AWS SAM CLI, that makes it easy for you to create and manage serverless applications. It particularly makes easy the scaffolding of a new project, as it creates the initial skeleton of a hello world application, so you can use it as a baseline and continue building your project from there. 

Run the following command to scaffold a new project:
```bash
sam init
```

It will prompt for project configuration parameters: 

#### sam init

Type `1` to select **AWS Quick Start Templates** then type `1` to select **Zip** as the package type

![samInit](/images/python/sam/cloud9_ide_sam_init.png)

Choose `python3.7` for runtime
![samInitPython](/images/python/sam/cloud9_ide_sam_init_python.png)

Leave default **sam-app** for project name and type `1` to select the **Hello World Example**
![samInitTemplate](/images/python/sam/cloud9_ide_sam_init_template.png)

{{% notice tip %}}
This command supports cookiecutter templates, so you could write your own custom scaffolding templates and specify them using the location flag, For example: sam init --location git+ssh://git@github.com/aws-samples/cookiecutter-aws-sam-python.git.
{{% /notice%}}

## Project should now be initialized

You should see a new folder `sam-app` created with a basic Hello World scaffolding.
![samInitComplete](/images/python/sam/cloud9_ide_sam_init_complete.png)

If you are interested in learning more about initializing SAM projects, you can find the full reference for the `sam init` command in the [SAM CLI reference](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-init.html).
