+++
title = "Write the buildspec file"
date = 2019-10-04T12:54:48-07:00
weight = 30
+++

A buildspec file is a series of commands in YAML format that CodeBuild runs to build your application. 

Create a new file named _buildspec.yml_ in the root of the _sam-app_ directory and copy the following contents into it. **It is very important that the file is placed in the root**, otherwise CodeBuild will not be able to find it.

In Cloud9, right click on the `sam-app` directory to create a new file. Name it `buildspec.yml`.

![CreateNewFileCloud9](/images/screenshot-cloud9-new-file.png)

Then, paste the following content into the file:

```
# ~/environment/sam-app/buildspec.yml

version: 0.2
phases:
  install:
    runtime-versions:
      nodejs: 10
    commands:
      # Install packages or any pre-reqs in this phase.
      - cd hello-world
      - npm install
  
  pre_build:
    commands:
      # Run tests, lint scripts or any other pre-build checks.
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

**Save the file**. It should look like this (take a moment to understand it):

![CreateBuildspec](/images/screenshot-buildspec.png)

### Push code changes
Commit your changes and push them to the repository.

```
git add .
git commit -m "Added buildspec.yml"
git push
```