+++
title = "Buildspec file"
date = 2021-08-30T08:30:00-06:00
weight = 30
+++

A [Buildspec File](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html) is a series of commands in YAML format that CodeBuild executes to build your application. This file is placed in the root folder of a SAM application and CodeBuild will automatically find it and run it during build time.

In your Cloud9 editor, create a new file named `buildspec.yml` in the root (top level) of the _sam-app_ directory by right clicking on the `sam-app` folder and selecting New file.

{{% notice tip %}}
The extension of the file can be either `yml` or `yaml`, CodeBuild will find it either way.
{{% /notice%}}

Then, paste the following content into the file:

```yaml
# ~/environment/sam-app/buildspec.yml

version: 0.2
phases:
  install:
    runtime-versions:
        dotnet: 3.1
    commands:
      # Install packages or any pre-reqs in this phase.
      # Upgrading SAM CLI to latest version
      - pip3 install --upgrade aws-sam-cli
      - sam --version
      - cd $CODEBUILD_SRC_DIR/src/HelloWorld
      - dotnet restore

  pre_build:
    commands:
      # Run tests, lint scripts or any other pre-build checks.
      - cd $CODEBUILD_SRC_DIR/test/HelloWorld.Test
      - dotnet restore
      - dotnet test
      
  build:
    commands:
      # Use Build phase to build your artifacts (compile, etc.)
      - cd $CODEBUILD_SRC_DIR
      - sam build
      
  post_build:
    commands:
      # Use Post-Build for notifications, git tags, upload artifacts to S3
      - sam package --output-template-file packaged.yaml --s3-bucket $PACKAGE_BUCKET --s3-prefix sam-cli

artifacts:
  discard-paths: yes
  files:
    # List of local artifacts that will be passed down the pipeline
    - packaged.yaml
```

**Save the file**. It should look like the following screenshot.

![CreateBuildspec](/images/csharp/buildpipe/cloud9_ide_buildspec.png)

Take a moment to understand the structure of the file and feel free to read the Buildsec Reference here: https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html.

### Push code changes

Commit your changes and push them to the repository.

```bash
cd ~/environment/sam-app
git add .
git commit -m "Added buildspec.yml"
git push
```

### Verify build succeeds

Navigate to your CodePipeline again, and wait for it to trigger automatically. This time the build will succeed: 

![BuildSucceeds](/images/csharp/buildpipe/aws_console_pipeline_build.png)