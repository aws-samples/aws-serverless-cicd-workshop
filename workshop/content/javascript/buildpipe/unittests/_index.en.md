+++
title = "Enable unit tests"
date = 2021-12-29T14:20:52-08:00
weight = 40
+++

To enable unit tests in your pipeline there are three steps.

1. Edit `codepipeline.yaml` to enable the `UnitTest` CodePipeline build step
1. Edit `pipeline/buildspec_unit_test.yml` to tell AWS CodeBuild how to run your unit tests.
1. Commit and push these changes.

### Edit codepipeline.yaml

Open up the `codepipeline.yaml` file in your editor. Search for the string `unit-test` and you will
find three sections that are commented out. Uncomment these three blocks of yaml. They should look
like the following. The line numbers shown are approximate and may not be the same as your
`codepipeline.yaml` file.

```yaml {linenos=true,linenostart=213}
# Uncomment and modify the following step for running the unit-tests
- Name: UnitTest
  Actions:
    - Name: UnitTest
      ActionTypeId:
        Category: Build
        Owner: AWS
        Provider: CodeBuild
        Version: "1"
      Configuration:
        ProjectName: !Ref CodeBuildProjectUnitTest
      InputArtifacts:
        - Name: SourceCodeAsZip
```

```yaml {linenos=true,linenostart=468}
Resource:
  # Uncomment the line below to enable the unit-tests
  - !GetAtt CodeBuildProjectUnitTest.Arn
```

```yaml {linenos=true,linenostart=578}
# Uncomment and modify the following step for running the unit-tests
CodeBuildProjectUnitTest:
  Type: AWS::CodeBuild::Project
  Properties:
    Artifacts:
      Type: CODEPIPELINE
    Environment:
      Type: LINUX_CONTAINER
      ComputeType: BUILD_GENERAL1_SMALL
      Image: aws/codebuild/amazonlinux2-x86_64-standard:3.0
    ServiceRole: !GetAtt CodeBuildServiceRole.Arn
    Source:
      Type: CODEPIPELINE
      BuildSpec: pipeline/buildspec_unit_test.yml
```

### Edit buildspec_unit_test.yml

Open the `pipeline/buildspec_unit_test.yml` file in your editor. Replace the contents with the
following:

```yaml
version: 0.2
phases:
  install:
    runtime-versions:
      nodejs: latest
  build:
    commands:
      # trigger the unit tests here
      - echo 'Running unit tests'
      - cd hello-world
      - npm install
      - npm run test
```

### Commit and push changes

```bash
git commit -am 'Enable unit tests in pipeline'
git push
```

### Watch the Pipeline self-update

Open up your Pipeline from the CodePipeline console. Since you've changed its configuration, you
will be able to see it self-update by adding a `UnitTest` step. Once the `UpdatePipeline` step
completes you'll see `UnitTest` show up. Remember the `UpdatePipeline` step deploys your
CloudFormation template, `codepipeline.yaml`. Any change you make to the Pipeline, or any resource
in that CloudFormation template, will be applied automatically once you commit.

![SimplePipeline](/images/chapter4-pipelines/code-pipeline.gif)

#### Congratulations! You have created a CI/CD pipeline for a Serverless application!
