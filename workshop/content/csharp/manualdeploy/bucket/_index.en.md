+++
title = "Let's talk about artifacts"
date = 2019-10-03T10:54:25-07:00
weight = 5
+++

_Artifacts_ refer to the output of your build process in the context of CI/CD. Artifacts are typically in the form of a zip/tar file, a jar or a binary. You then take these artifacts and deploy them onto your different environments (i.e. Dev, Test, Prod). For Serverless projects, artifacts must be uploaded to an S3 bucket for the Lambda service to pick them up. The SAM CLI takes care of managing this process of uploading artifacts to S3 and referencing them at deployment time.

### The Zip file

The first artifact that gets generated in a Serverless project is your codebase, which gets compressed in a zip file and uploaded to an S3 bucket automatically by the SAM CLI during the _package_ phase (more on this later).

### The Packaged Template

The second artifact that SAM CLI generates during the _package_ phase is the packaged template. Which is basically a copy of your project's `template.yaml`, except that it references the location of the zip file (first artifact) in the S3 bucket. The following image shows an example of a packaged template.

![SamPackagedTemplate](/images/csharp/manualdeploy/packaged_template.png)

Notice how the `CodeUri` references the zip file on an S3 bucket, rather than on a local directory. This is how AWS Lambda is able to pull your code at deployment time.

