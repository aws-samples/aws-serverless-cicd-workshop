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
![samInit](/images/java/chapter1/init/quick-start-template.png)

#### Type `1` to select Zip as the package type
![samInit](/images/java/chapter1/init/package-type.png)

#### Type `14` to select the Java 8 runtime
![samInit](/images/java/chapter1/init/runtime.png)

#### Type `1` to select maven 
![samInit](/images/java/chapter1/init/maven.png)

#### Press enter to accept the default `sam-app` for project name
![samInit](/images/java/chapter1/init/default-project-name.png)

#### Type `1` to select the Hello World Example
![samInit](/images/java/chapter1/init/hello-world-example.png)

{{% notice tip %}}
This command supports cookiecutter templates, so you could write your own custom scaffolding templates and specify them using the location flag, For example: sam init --location git+ssh://git@github.com/aws-samples/cookiecutter-aws-sam-python.git.
{{% /notice%}}

## Project should now be initialized

You should see a new folder `sam-app` created with a basic Hello World scaffolding.
![samInit](/images/java/chapter1/init/project-layout.png)

If you are interested in learning more about initializing SAM projects, you can find the full reference for the `sam init` command in the [SAM CLI reference](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-init.html).