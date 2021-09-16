+++
title = "Creating the SAM Pipeline"
date = 2019-11-01T15:26:09-07:00
weight = 21
+++

## Install the latest AWS SAM CLI

If you have run the ```boostrap.sh``` script  from the setup section SAM Piplelines are ready to go!  If you haven't run through the setup yet, head there now.


### Initialize project

Now, let's head to our exsiting folder within the _sam-app_ directory where the pipeline code will reside.
```
cd ~/environment/sam-app
sam pipeline init --bootstrap
```

This guides you through a series of questions to help create a .gitlab-ci.yml file. The --bootstrap option enables you to set up AWS pipeline stage resources before the template file is initialized:

1. Enter 1, to choose AWS Quick Start Pipeline Templates
1. Enter 4 to choose to create a AWS Code Pipeline template file, which includes a two stage pipeline.
1. Next AWS SAM reports “No bootstrapped resources were detected.” and asks if you want to set up a new CI/CD stage. Enter Y to set up a new stage:

Set up the dev stage by answering the following questions:

1. Enter `dev` for the Stage name.
1. AWS SAM CLI detects your AWS CLI credentials file. It uses a named profile to create the required
resources for this stage. ***Select Option 2 - `default (named profile)***
1. Press enter to select the default region - or enter a region for the stage name (ie. “us-east-1”).
1. Keep the pipeline IAM user, ARN and pipeline and CloudFormation execution role ARNs blank to generate these resources automatically.
1. An Amazon S3 bucket is required to store application build artifacts during the deployment process. **Keep this option blank for AWS SAM Pipelines to generate a new S3 bucket.**
1. Enter N to specify you are not using Lambda functions packages as container images.
1. Press “Enter” to confirm the resources to be created.
1. Enter "Y" to create the following required resources for the `dev` environment

![](/images/chapter4-pipelines/screenshot-sam-pipe-dev.png)

AWS SAM Pipelines creates a PipelineUser with an associated ACCESS_KEY_ID and SECRET_ACCESS_KEY which AWS Pipelines uses to deploy artifacts to your AWS accounts. An S3 bucket is created along with two roles PipelineExecutionRole and CloudFormationExecutionRole.

Make a note of these values. You use these in the following steps to configure the production deployment environment and CI/CD provider.

Creating the production stage

The AWS SAM Pipeline command automatically detects that a second stage is required to complete the AWS Pipleine template, and prompts you to go through the set-up process for this:

1. Enter “Y” to continue to build the next pipeline stage resources.

![](/images/chapter4-pipelines/screenshot-sam-pipe-prod1.png)

1. When prompted for Stage Name, enter `prod`.
1. AWS SAM CLI detects your AWS CLI credentials file. It uses a named profile to create the required
resources for this stage. ***Select Option 2 - `default (named profile)`***
1. Press enter to select the default region - or enter a region for the stage name (ie. `us-east-1`).
1. Press enter to use the same Pipeline IAM user ARN created in the previous step.
1. When prompted for the pipeline execution role ARN and the CloudFormation execution role ARN, leave blank to allow the bootstrap process to create them.
1. Provide the same answers as in the previous steps 5-7.

The AWS resources and permissions are now created to run the deployment pipeline for a dev and prod stage. The definition of these two stages is saved in .aws-sam/pipeline/pipelineconfig.toml.

AWS SAM Pipelines now automatically continues the walkthrough to create a GitLab deployment pipeline file.

![](/images/chapter4-pipelines/screenshot-sam-pipe-prod.png)

Setup the Git Provider
1. Select 2 for CodeCommit
1. Provide the Code Commit repository you created during the earlier step: `sam-app`
1. Press enter to confirm the Git Branch as `[main]`
1. When prompted for the template file path, press enter for `[template.yaml]`

{{%notice note%}}
In the next section, you are creating two sets of AWS Resources (infrasturucre).  One for the Dev stage and one for the Prod stage.  You will need to specific a unique application stack for each.
{{%/notice%}}

Configure Stage 1 for Code Commit:
1. Enter 1 for the stage name to select the dev stage
1. Type `sam-app-dev` to create a unique sam-app application stack

Configure Stage 2 for Code Commit:
1. Enter 2 for the stage name to select the prod stage
1. type `sam-app-prod` to create a unique sam-app application stack

```text
Checking for existing stages...

What is the Git provider?
        1 - Bitbucket
        2 - CodeCommit
        3 - GitHub
        4 - GitHubEnterpriseServer
Choice []: 2
What is the CodeCommit repository name?: sam-app
What is the Git branch used for production deployments? [main]:
What is the template file path? [template.yaml]:
We use the stage name to automatically retrieve the bootstrapped resources created when you ran `sam pipeline bootstrap`.

Here are the stage names detected in .aws-sam/pipeline/pipelineconfig.toml:
        1 - dev
        2 - prod
What is the name of stage 1 (as provided during the bootstrapping)?
Select an index or enter the stage name: 1
What is the sam application stack name for stage 1? [sam-app]: sam-app-dev
Stage 1 configured successfully, configuring stage 2.

Here are the stage names detected in .aws-sam/pipeline/pipelineconfig.toml:
        1 - dev
        2 - prod
What is the name of stage 2 (as provided during the bootstrapping)?
Select an index or enter the stage name: 2
What is the sam application stack name for stage 2? [sam-app]: sam-app-prod
Stage 2 configured successfully.
```

you should see that the following files were succesfully created:

```text
- assume-role.sh
- codepipeline.yaml
- pipeline/buildspec_build_package.yml
- pipeline/buildspec_deploy.yml
- pipeline/buildspec_feature.yml
- pipeline/buildspec_integration_test.yml
- pipeline/buildspec_unit_test.yml
```
### Project structure

What we've just done is create the CloudFormation templates to create a full CI/CD Pipeline using
AWS CodePipeline. There are additional configuration files which will be used by CodeBuild which
will run our build, test and deploy steps.

Your project should have the structure below (only the most relevant files and folders are shown).

```
└── sam-app
    ├── assume-role.sh          # Helper script for CodePipeline
    ├── codepipeline.yaml       # CodePipeline CloudFormation template
    ├── events
    ├── hello-world/            # SAM application root
    ├── pipeline/               # Build Specs for CodeBuild
    ├── README.md
    ├── samconfig.toml          # Config file for manual SAM deployments
    └── template.yaml           # SAM template
```

### Push the changes

{{% notice info %}}
**We haven't created any CI/CD systems just yet!** We'll do that in the next section. First, we need to
commit our CI/CD configuration files into our repository. Once that's done, we can create our CodePipeline.
{{% /notice %}}


In the terminal, run the following commands from the root directory of your `sam-app` project.

```
git add .
git commit -m "Adding SAM CI/CD Pipeline definition"
git push
```
