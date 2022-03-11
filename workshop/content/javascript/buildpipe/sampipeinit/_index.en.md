+++
title = "Creating the SAM Pipeline"
date = 2019-11-01T15:26:09-07:00
weight = 21
+++

{{% notice info %}}
If you have **not** run the `boostrap.sh` script go to [Getting started]( {{< relref
"javascript/setup/bootstrap#boostrap-script" >}} ) section.
{{% /notice %}}

There are three distinct steps with SAM Pipelines and AWS CodePipeline.

1. [Create required IAM roles and infrastructure]( {{< ref "#create-required-iam-roles-and-infrastructure" >}} )
1. [Create CloudFormation pipeline template]( {{< ref "#create-cloudformation-pipeline-template" >}} )
1. [Deploy CloudFormation pipeline template]( {{< ref "#deploy-cloudformation-pipeline-template" >}} )

SAM Pipelines automates all of this for us.

The `sam pipeline init --bootstrap` command will guide you through a _long_ series of
questions. In this lab, it's critical to answer the questions as documented below.

### Create required IAM roles and infrastructure

#### Dev stage

```
cd ~/environment/sam-app
sam pipeline init --bootstrap
```

A list of the questions and required anwers for this workshop is enumerated below. Note that numbers
may be different when choosing from an enumerated list. The full output and answers are provided
below as an additional reference.

1. Select a pipeline template to get started: `AWS Quick Start Pipeline Templates` (1)
1. Select CI/CD system: `AWS CodePipeline` (5)
1. Do you want to go through stage setup process now? [y/N]: `y`
1. [1] Stage definition. Stage configuration name: `dev`
1. [2] Account details. Select a credential source to associate with this stage: `default (named profile)` (2)
1. Enter the region in which you want these resources to be created: `Your region of choice`
1. Enter the pipeline IAM user ARN if you have previously ... [] `return/enter`
1. Enter the pipeline execution role ARN if you have previously ... []: `return/enter`
1. Enter the CloudFormation execution role ARN if you have previously ... []: `return/enter`
1. Please enter the artifact bucket ARN for your Lambda function. If you do not ... []: `return/enter`
1. Does your application contain any IMAGE type Lambda functions? [y/N]: `N`
1. Press enter to confirm the values above ... : `return/enter`
1. Should we proceed with the creation? [y/N]: `y`

```text
sam pipeline init generates a pipeline configuration file that your CI/CD system
can use to deploy serverless applications using AWS SAM.
We will guide you through the process to bootstrap resources for each stage,
then walk through the details necessary for creating the pipeline config file.

Please ensure you are in the root folder of your SAM application before you begin.

Select a pipeline template to get started:
        1 - AWS Quick Start Pipeline Templates
        2 - Custom Pipeline Template Location
Choice: 1

Cloning from https://github.com/aws/aws-sam-cli-pipeline-init-templates.git
Select CI/CD system
        1 - Jenkins
        2 - GitLab CI/CD
        3 - GitHub Actions
        4 - Bitbucket Pipelines
        5 - AWS CodePipeline
Choice: 5
You are using the 2-stage pipeline template.
 _________    _________
|         |  |         |
| Stage 1 |->| Stage 2 |
|_________|  |_________|

Checking for existing stages...

[!] None detected in this account.

Do you want to go through stage setup process now? If you choose no, you can still reference other bootstrapped resources. [y/N]: y

For each stage, we will ask for [1] stage definition, [2] account details, and [3]
reference application build resources in order to bootstrap these pipeline
resources.

We recommend using an individual AWS account profiles for each stage in your
pipeline. You can set these profiles up using aws configure or ~/.aws/credentials. See
[https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-set-up-credentials.html].


Stage 1 Setup

[1] Stage definition
Enter a configuration name for this stage. This will be referenced later when you use the sam pipeline init command:
Stage configuration name: dev

[2] Account details
The following AWS credential sources are available to use.
To know more about configuration AWS credentials, visit the link below:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html
        1 - Environment variables (not available)
        2 - default (named profile)
        q - Quit and configure AWS credentials
Select a credential source to associate with this stage: 2
Associated account 123456789012 with configuration dev.

Enter the region in which you want these resources to be created [us-west-2]:
Enter the pipeline IAM user ARN if you have previously created one, or we will create one for you []:

[3] Reference application build resources
Enter the pipeline execution role ARN if you have previously created one, or we will create one for you []:
Enter the CloudFormation execution role ARN if you have previously created one, or we will create one for you []:
Please enter the artifact bucket ARN for your Lambda function. If you do not have a bucket, we will create one for you []:
Does your application contain any IMAGE type Lambda functions? [y/N]:

[4] Summary
Below is the summary of the answers:
        1 - Account: 123456789012
        2 - Stage configuration name: dev
        3 - Region: us-west-2
        4 - Pipeline user: [to be created]
        5 - Pipeline execution role: [to be created]
        6 - CloudFormation execution role: [to be created]
        7 - Artifacts bucket: [to be created]
        8 - ECR image repository: [skipped]
Press enter to confirm the values above, or select an item to edit the value:

This will create the following required resources for the 'dev' configuration:
        - Pipeline IAM user
        - Pipeline execution role
        - CloudFormation execution role
        - Artifact bucket
Should we proceed with the creation? [y/N]: y
        Creating the required resources...
```

Once this completes, you will see output which looks like the following:

```text
        Successfully created!
The following resources were created in your account:
        - Pipeline IAM user
        - Pipeline execution role
        - CloudFormation execution role
        - Artifact bucket
Pipeline IAM user credential:
        AWS_ACCESS_KEY_ID: AAAAAAAAAAAAIFRDVPDX
        AWS_SECRET_ACCESS_KEY: xxxxxxxxxxxxxxxxxxxxxxkMYI9RatNgVcIybUwh
```

These resources were created with a CloudFormation stack that SAM Pipelines synthesized and
launched. You may optionally navigate to the CloudFormation console and inspect this stack to see
everything that was created.

In this step, SAM pipelines created a Pipeline IAM user with an associated `ACCESS_KEY_ID`
and `SECRET_ACCESS_KEY`, shown in the output. The CodePipeline we will eventually create uses this
user to deploy artifacts to your AWS accounts. This IAM user will be the default value in subsequent
steps.

![](/images/chapter4-pipelines/aws-sam-cli-managed-dev-pipeline-resources.png)

#### Prod stage

SAM Pipelines detects that a second stage is required and prompts you
to go through the set-up process for this new stage. Since you have created the necessary resource for the
`dev` build stage, you need to go through the same steps for a `prod` stage. You will see output
that looks like the following.

![](/images/chapter4-pipelines/screenshot-sam-pipe-prod1.png)

Select `y` to the question, "Do you want to go through stage setup process now? ... [y/N]:". This
will continue the wizard to setup the `prod` stage.

Most questions can be answered the same as the `dev` stage, created above. The **one** change you
need to make is first question which is the "Stage configuration name" which should be `prod`.
Also note the default value for the "Pipeline IAM user ARN" (question 4) prompt will be filled in.
This is the ARN for the Pipeline user created during the `dev` stage, above.

<!-- An S3 bucket is created along with two roles PipelineExecutionRole and CloudFormationExecutionRole. -->

1. [1] Stage definition. Stage configuration name: `prod`
1. [2] Account details. Select a credential source to associate with this stage: `default (named profile)` (2)
1. Enter the region in which you want these resources to be created: `Your region of choice`
1. Pipeline IAM user ARN: arn:aws:iam::123456789012:user/aws-sam... : `return/enter`
1. Enter the pipeline execution role ARN if you have previously ... []: `return/enter`
1. Enter the CloudFormation execution role ARN if you have previously ... []: `return/enter`
1. Please enter the artifact bucket ARN for your Lambda function. If you do not ... []: `return/enter`
1. Does your application contain any IMAGE type Lambda functions? [y/N]: `N`
1. Press enter to confirm the values above ... : `return/enter`
1. Should we proceed with the creation? [y/N]: `y`

Once this is complete, SAM will launch a new CloudFormation stack. This stack will create new
resources for your `prod` deployment. You can optionally inspect this template in the CloudFormation
console. It looks very similar to the `dev` pipeline stack.

![](/images/chapter4-pipelines/aws-sam-cli-managed-prod-pipeline-resources.png)

## Create CloudFormation pipeline template

Now that AWS SAM has created supporting resources we'll continue to create a CloudFormation template
that will define our entire CI/CD pipeline.

A list of the questions and required anwers for this workshop is enumerated below. Note that numbers
may be different when choosing from an enumerated list. The full output and answers is provided
below as an additional reference.

1. What is the Git provider? Choice []: `CodeCommit` (2)
1. What is the CodeCommit repository name?: `sam-app`
1. What is the Git branch used for production deployments? [main]: `main`
1. What is the template file path? [template.yaml]: `template.yaml`
1. Select an index or enter the stage 1's configuration name (as provided during the bootstrapping): `1`
1. What is the sam application stack name for stage 1? [sam-app]: `sam-app-dev`
1. Select an index or enter the stage 2's configuration name (as provided during the bootstrapping): `2`
1. What is the sam application stack name for stage 2? [sam-app]: `sam-app-prod`

```text
What is the Git provider?
        1 - Bitbucket
        2 - CodeCommit
        3 - GitHub
        4 - GitHubEnterpriseServer
Choice []: 2
What is the CodeCommit repository name?: sam-app
What is the Git branch used for production deployments? [main]:
What is the template file path? [template.yaml]:
We use the stage configuration name to automatically retrieve the bootstrapped resources created when you ran `sam pipeline bootstrap`.

Here are the stage configuration names detected in .aws-sam/pipeline/pipelineconfig.toml:
        1 - dev
        2 - prod
Select an index or enter the stage 1's configuration name (as provided during the bootstrapping): 1
What is the sam application stack name for stage 1? [sam-app]: sam-app-dev
Stage 1 configured successfully, configuring stage 2.

Here are the stage configuration names detected in .aws-sam/pipeline/pipelineconfig.toml:
        1 - dev
        2 - prod
Select an index or enter the stage 2's configuration name (as provided during the bootstrapping): 2
What is the sam application stack name for stage 2? [sam-app]: sam-app-prod
Stage 2 configured successfully.

To deploy this template and connect to the main git branch, run this against the leading account:
`sam deploy -t codepipeline.yaml --stack-name <stack-name> --capabilities=CAPABILITY_IAM`.
SUMMARY
We will generate a pipeline config file based on the following information:
        What is the Git provider?: CodeCommit
        What is the CodeCommit repository name?: sam-app
        ...
        What is the AWS region for stage 2?: us-west-2
Successfully created the pipeline configuration file(s):
        - assume-role.sh
        - codepipeline.yaml
        - pipeline/buildspec_build_package.yml
        - pipeline/buildspec_deploy.yml
        - pipeline/buildspec_feature.yml
        - pipeline/buildspec_integration_test.yml
        - pipeline/buildspec_unit_test.yml
```

What we've just done is create the CloudFormation template and supporting configuration files to
create a full CI/CD Pipeline using AWS CodePipeline, CodeBuild and other AWS services.

Your project should have the structure below (only the most relevant files and folders are shown).

```
└── sam-app
    ├── codepipeline.yaml       # (new) CodePipeline CloudFormation template
    ├── assume-role.sh          # (new) Helper script for CodePipeline
    ├── pipeline/               # (new) Build Specs for CodeBuild
    ├── events
    ├── hello-world/            # SAM application root
    ├── README.md
    ├── samconfig.toml          # Config file for manual SAM deployments
    └── template.yaml           # SAM template
```

You can optionally open up `codepipeline.yaml` and
other files to see what SAM Pipelines created for us. Looking at `codepipeline.yaml` you can see
that there are nearly 700 lines of CloudFormation that SAM created. Think about how much time
you just saved using SAM Pipelines rather than crafting this by hand!

{{% notice info %}}
**We haven't created any CI/CD systems just yet!** You'll do that next. First, you need to
commit your CI/CD configuration files into your repository. Once that's done, you can create your
CodePipeline with CloudFormation, via SAM.
{{% /notice %}}

### Deploy CloudFormation pipeline template

We need to add the new CI/CD configuration files to our repository.

```text
$ git status
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        assume-role.sh
        codepipeline.yaml
        pipeline/
```

In the terminal, run the following commands from the root directory of your `sam-app` project.

```
git add .
git commit -m "Adding SAM CI/CD Pipeline definition"
git push
```

Now that configuration is checked into source control you can create a new CloudFormation stack
which will set up our CI/CD pipeline. You will use the `sam deploy` command to launch this new
stack. It's important to recognize that you're using SAM's ability to launch arbitrary
CloudFormation templates. SAM isn't building or deploying your serverless application here, rather
launching the `codepipeline.yaml` CI/CD template.

```
sam deploy -t codepipeline.yaml --stack-name sam-app-pipeline --capabilities=CAPABILITY_IAM
```

**This will take a few minutes to complete, so be patient!** You can optionally open the
CloudFormation console to watch the progress of this new stack. Eventually the stack will complete
and you can see the final AWS resources it created.

![](/images/chapter4-pipelines/cloudformation-sam-app-pipeline.png)

#### Navigate to the next section to see how your new CI/CD pipeline deploys your serverless application to the `dev` and `prod` stages.
