+++
title = "Appendix"
date = 2020-07-06T17:49:47-04:00
weight = 1000
pre = "<b>7. </b>"
+++

Prior versions of this workshop used the AWS CDK to create the CI/CD pipeline. CDK is a fantastic
tool! If you are looking for the CDK version, below is an example CI/CD pipeline in TypeScript using
CDK V2.

Note that this example from `v3` of this workshop is missing a few features compared to the one setup by
SAM Pipelines. It does not have a specific unit test phase and does not self-update.

```typescript
import { Stack, StackProps } from "aws-cdk-lib"
import { Construct } from "constructs"

import * as codebuild from "aws-cdk-lib/aws-codebuild"
import * as codecommit from "aws-cdk-lib/aws-codecommit"
import * as codepipeline from "aws-cdk-lib/aws-codepipeline"
import * as codepipeline_actions from "aws-cdk-lib/aws-codepipeline-actions"
import * as s3 from "aws-cdk-lib/aws-s3"

export class ServerlessCicdPipelineStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props)

    const artifactsBucket = new s3.Bucket(this, "ArtifactsBucket")

    const codeRepo = codecommit.Repository.fromRepositoryName(this, "AppRepository", "sam-app")
    // Pipeline creation starts
    const pipeline = new codepipeline.Pipeline(this, "Pipeline", {
      artifactBucket: artifactsBucket,
    })

    // Declare source code as an artifact
    const sourceOutput = new codepipeline.Artifact()

    // Add source stage to pipeline
    pipeline.addStage({
      stageName: "Source",
      actions: [
        new codepipeline_actions.CodeCommitSourceAction({
          actionName: "CodeCommit_Source",
          repository: codeRepo,
          output: sourceOutput,
          branch: "main",
        }),
      ],
    })

    // Declare build output as artifacts
    const buildOutput = new codepipeline.Artifact()

    // Declare a new CodeBuild project
    const buildProject = new codebuild.PipelineProject(this, "Build", {
      environment: { buildImage: codebuild.LinuxBuildImage.AMAZON_LINUX_2_2 },
      environmentVariables: {
        PACKAGE_BUCKET: {
          value: artifactsBucket.bucketName,
        },
      },
    })

    // Add the build stage to our pipeline
    pipeline.addStage({
      stageName: "Build",
      actions: [
        new codepipeline_actions.CodeBuildAction({
          actionName: "Build",
          project: buildProject,
          input: sourceOutput,
          outputs: [buildOutput],
        }),
      ],
    })

    // Prod stage
    pipeline.addStage({
      stageName: "Dev",
      actions: [
        new codepipeline_actions.CloudFormationCreateReplaceChangeSetAction({
          actionName: "CreateChangeSet",
          templatePath: buildOutput.atPath("packaged.yaml"),
          stackName: "sam-app-dev",
          adminPermissions: true,
          changeSetName: "sam-app-dev-changeset",
          runOrder: 1,
        }),
        new codepipeline_actions.CloudFormationExecuteChangeSetAction({
          actionName: "Deploy",
          stackName: "sam-app-dev",
          changeSetName: "sam-app-dev-changeset",
          runOrder: 2,
        }),
      ],
    })

    // Production stage
    pipeline.addStage({
      stageName: "Prod",
      actions: [
        new codepipeline_actions.CloudFormationCreateReplaceChangeSetAction({
          actionName: "CreateChangeSet",
          templatePath: buildOutput.atPath("packaged.yaml"),
          stackName: "sam-app-prod",
          adminPermissions: true,
          changeSetName: "sam-app-prod-changeset",
          runOrder: 1,
        }),
        new codepipeline_actions.CloudFormationExecuteChangeSetAction({
          actionName: "Deploy",
          stackName: "sam-app-prod",
          changeSetName: "sam-app-prod-changeset",
          runOrder: 2,
        }),
      ],
    })
  }
}
```

The following `buildspec.yml` file shows how to build and test a Node AWS SAM application with the
pipeline above. It's possible to extract the test command into it's own pipeline stage so that tests
are run once rather than per-stage.

```yaml
# sam-app/buildspec.yml
version: 0.2
phases:
  install:
    runtime-versions:
      nodejs: 12
    commands:
      # Install packages or any pre-reqs in this phase.
      # Upgrading SAM CLI to latest version
      - pip3 install --upgrade aws-sam-cli
      - sam --version
      - cd hello-world
      - npm install

  pre_build:
    commands:
      - npm run test

  build:
    commands:
      # Use Build phase to build your artifacts (compile, etc.)
      - cd ..
      - sam build

  post_build:
    commands:
      # Use Post-Build for notifications, git tags, upload artifacts to S3
      - sam package --s3-bucket $PACKAGE_BUCKET --output-template-file packaged.yaml

artifacts:
  discard-paths: yes
  files:
    # List of local artifacts that will be passed down the pipeline
    - packaged.yaml
```
