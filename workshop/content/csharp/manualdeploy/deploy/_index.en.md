+++
title = "Deploy the app"
date = 2021-08-30T08:30:00-06:00
weight = 20
+++

The `sam deploy` command deploys your application by launching a CloudFormation stack. This command has a guided interactive mode, which you enable by specifying the _--guided_ parameter. It is recommended to deploy with guided mode for the first time as it will capture the configuration for future deployments.

Run the following command in the same directory level where the _template.yaml_ is located:

```bash
cd ~/environment/sam-app
sam deploy --guided
```

It will ask for certain input parameters.  Accept the default for named parameters and choose `y` for the other parameters.

![SamDeployGuided](/images/csharp/manualdeploy/cloud9_ide_sam_deploy_guided.png)

### Confirm deployment

At some point, SAM will ask for deployment confirmation. This is possible because it first creates a CloudFormation ChangeSet, and then it asks for confirmation to execute it. This is similar to a _dry run deployment_ and is a best practice when doing deployments via CloudFormation. Type `y` to confirm.

![SamDeployPreview](/images/csharp/manualdeploy/cloud9_ide_sam_deploy_preview.png)

### Deployment completed
This command might take a few minutes to finish because it is creating the resources (Lambda function, API Gateway, and IAM roles) on the AWS account. When it completes successfully, you should see an output similar to the following:

![SamDeployOutputs](/images/csharp/manualdeploy/cloud9_ide_sam_deploy_outputs.png)

### What just happened?

The guided deployment does few things for you. Let's take a quick look at what happened under the hood during the guided deployment to understand this process better.

**1)** Your codebase gets packaged in a zip file.  
**2)** SAM creates an S3 bucket in your account, if it doesn't already exist.  
**3)** Zip file is uploaded to the S3 bucket.  
**4)** SAM creates the [packaged template](/python/manualdeploy.html#the-packaged-template) that references the location of the zip file on S3.  
**5)** This template is also uploaded to the S3 bucket.  
**6)** SAM starts the deployment via CloudFormation changesets.  

The first time you do a guided deployment, a new file `samconfig.toml` is created in the root of your project with your specified deployment parameters, this is so that the next time you execute `sam deploy`, it uses the same parameters without having you to enter them again.

![SamConfigToml](/images/csharp/manualdeploy/cloud9_ide_samconfig.png)

If you want to learn more about guided deployments and the `samconfig.toml` file, here is a good Blog Post: https://aws.amazon.com/blogs/compute/a-simpler-deployment-experience-with-aws-sam-cli. 
