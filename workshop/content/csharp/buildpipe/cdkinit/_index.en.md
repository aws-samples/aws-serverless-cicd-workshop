+++
title = "Setup a CDK project"
date = 2021-08-30T08:30:00-06:00
weight = 21
+++

## Install the latest CDK

If you are using Cloud9, the CDK is already pre-installed but it will likely be a few versions old. Likewise, the Node.js runtime is outdated.

Run the following commands from the Cloud9 terminal to update Node.js and and install the latest AWS CDK:
```bash
brew install node@14
echo 'export PATH="/home/linuxbrew/.linuxbrew/opt/node@14/bin:$PATH"' >> /home/ec2-user/.bash_profile
. ~/.bash_profile 
npm install -g aws-cdk
```

### Initialize project

Now, let's create a folder within our _sam-app_ directory where the pipeline code will reside.
```bash
cd ~/environment/sam-app
mkdir pipeline
cd pipeline
```

Initialize a new CDK project within the _pipeline_ folder by running the following command:

```bash
cdk init --language csharp
```

Now install the CDK modules that we will be using to build a pipeline: 

```bash
cd src/Pipeline
dotnet restore
dotnet add package Amazon.CDK
dotnet add package Amazon.CDK.AWS.CodeBuild
dotnet add package Amazon.CDK.AWS.CodeCommit
dotnet add package Amazon.CDK.AWS.CodePipeline
dotnet add package Amazon.CDK.AWS.CodePipeline.Actions
dotnet add package Amazon.CDK.AWS.IAM
dotnet add package Amazon.CDK.AWS.S3
dotnet add package Amazon.CDK.Pipelines
```

### Project structure

At this point, your project should have the structure below (only the most relevant files and folders are shown). Within the CDK project, the main file you will be interacting with is the `PipelineStack.cs`. Don't worry about the rest of the files for now. 

```
sam-app                             # SAM application root
├── pipeline                        # CDK project root
│   └── src
│       ├── Pipeline
│       │   ├── Pipeline.csproj
│       │   ├── PipelineStack.cs    # Pipeline definition
│       │   └── Program.cs          # Entry point for CDK project
├── samconfig.toml                  # Config file for manual deployments
├── src
│   └── HelloWorld                  # Lambda code
├── template.yaml                   # SAM template
└── test
```

### Modify stack name

Open the `Program.cs` file, which is your entry point to the CDK project, and change the name of the stack to **sam-app-cicd**. 

![CdkEntryPoint](/images/csharp/buildpipe/cloud9_ide_pipeline_app.png) 

**Save the file**.

