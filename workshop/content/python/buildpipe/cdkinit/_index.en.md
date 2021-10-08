+++
title = "Setup a CDK project"
date = 2021-08-30T08:30:00-06:00
weight = 21
+++

## Install the latest CDK

If you are using Cloud9, the CDK is already pre-installed but it will likely be a few versions old. Likewise, the Node.js runtime is outdated.

Run the following commands from the Cloud9 terminal to update Node.js and and install the latest AWS CDK:
```bash
nvm install lts/fermium
nvm alias default lts/fermium
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
cdk init --language python
```

Now install the CDK modules that we will be using to build a pipeline: 

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
pip install aws-cdk.aws-s3 aws-cdk.aws_codebuild aws-cdk.aws_codecommit aws-cdk.aws_codepipeline aws-cdk.aws_codepipeline_actions
```

After a few seconds, our new CDK project should look like this:

![CdkInit](/images/python/buildpipe/cloud9_ide_cdk_pipeline.png) 

### Project structure

At this point, your project should have the structure below (only the most relevant files and folders are shown). Within the CDK project, the main file you will be interacting with is the `pipeline_stack.py`. Don't worry about the rest of the files for now. 

```
sam-app                             # SAM application root
├── hello_world                     # Lambda code
├── pipeline
│   ├── app.py                      # Entry point for CDK project
│   ├── pipeline                    # CDK project root
│   │       └── pipeline_stack.py   # Pipeline definition
│   ├── requirements.txt
│   ├── setup.py
├── samconfig.toml                  # Config file for manual deployments
└── template.yaml                   # SAM template
```

### Modify stack name

Open the `app.py` file, which is your entry point to the CDK project, and change the name of the stack to **sam-app-cicd**. 

![CdkEntryPoint](/images/python/buildpipe/cloud9_ide_pipeline_app.png) 

**Save the file**.

