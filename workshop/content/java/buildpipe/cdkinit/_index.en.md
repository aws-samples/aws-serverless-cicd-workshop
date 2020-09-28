+++
title = "Setup a CDK project"
date = 2019-11-01T15:26:09-07:00
weight = 21
+++

## Install the latest CDK

If you are using Cloud9, the CDK is already pre-installed but it will likely be a few versions old. Run the following commands from the Cloud9 terminal to remove your current version and install the latest one:
```
npm uninstall -g aws-cdk
npm install -g aws-cdk
```

{{% notice tip %}}
If the Cloud9 terminal returns an error, use the `--force` flag: `npm install -g aws-cdk --force`
{{% /notice %}}


### Initialize project

Now, let's create a folder within our _sam-app_ directory where the pipeline code will reside.
```
cd ~/environment/sam-app
mkdir pipeline
cd pipeline
```

Initialize a new CDK project within the _pipeline_ folder by running the following command:

```
cdk init --language java
```

After a few seconds, our new CDK project should look like this:

![CdkInit](/images/java/chapter4/cdkinit/cdk-init.png)

{{% notice info %}}
If you are using Cloud9 and get an insufficent space or `ENOSPC: no space left on device` error, you may resize your volume by using the following commands from your Cloud9 terminal.
{{% /notice %}}
```bash
wget https://cicd.serverlessworkshops.io/assets/resize.sh
chmod +x resize.sh
./resize.sh 20
```

### Project structure

At this point, your project should have the structure below (only the most relevant files and folders are shown). Within the CDK project, the main file you will be interacting with is the _PipelineStack.java_. Don't worry about the rest of the files for now. 

```
sam-app                                         # SAM application root
├── events
│   └── event.json
├── HelloWorldFunction                          # Lambda code
├── pipeline                                    # CDK project root
│   ├── cdk.json
│   ├── pom.xml
│   └── src
│       ├── main
│       │   └── java
│       │       └── com
│       │           └── myorg
│       │               ├── PipelineApp.java    # Entry point for CDK project
│       │               └── PipelineStack.java  # Pipeline definition
│       └── test
│           └── java
│               └── com
│                   └── myorg
│                       └── PipelineTest.java
└── template.yaml                               # SAM template
```

Now add the CDK dependencies that we will be using to build a pipeline. Add the following maven dependencies to you pom.xml:

```$xml
        <dependency>
            <groupId>software.amazon.awscdk</groupId>
            <artifactId>iam</artifactId>
            <version>${cdk.version}</version>
        </dependency>
        <dependency>
            <groupId>software.amazon.awscdk</groupId>
            <artifactId>s3</artifactId>
            <version>${cdk.version}</version>
        </dependency>
        <dependency>
            <groupId>software.amazon.awscdk</groupId>
            <artifactId>codecommit</artifactId>
            <version>${cdk.version}</version>
        </dependency>
        <dependency>
            <groupId>software.amazon.awscdk</groupId>
            <artifactId>codepipeline</artifactId>
            <version>${cdk.version}</version>
        </dependency>
        <dependency>
            <groupId>software.amazon.awscdk</groupId>
            <artifactId>codepipeline-actions</artifactId>
            <version>${cdk.version}</version>
        </dependency>
        <dependency>
            <groupId>software.amazon.awscdk</groupId>
            <artifactId>codebuild</artifactId>
            <version>${cdk.version}</version>
        </dependency>
```

Your pom.xml should look like this:

![CdkEntryPoint](/images/java/chapter4/cdkinit/pom-dependencies.png)

### Modify stack name

Open the `src/main/java/com/myorg/PipelineApp.java` file, which is your entry point to the CDK project, and change the name of the stack to **sam-app-cicd**. 

![CdkEntryPoint](/images/java/chapter4/cdkinit/pipeline-app.png)

**Save the file**.

