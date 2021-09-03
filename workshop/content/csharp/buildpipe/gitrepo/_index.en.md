+++
title = "Create a Git Repository"
date = 2021-08-30T08:30:00-06:00
weight = 5
+++

Any CI/CD pipeline starts with a code repository. In this workshop we use AWS CodeCommit for ease of integration, but you could use other source code integrations, like GitHub for example. 

Run the following command from your terminal to create a new CodeCommit repository:

```bash
aws codecommit create-repository --repository-name sam-app
```

You should see the following output.

![CreateCodeCommit](/images/csharp/buildpipe/codecommit_create.png) 


One of the cool things about CodeCommit is the support for IAM authentication. And if you are running this workshop from a Cloud9 workspace, you can leverage the fact that your terminal is already pre-authenticated with valid AWS credentials.

Configure the git client with your name and email, so your commits have an author defined.

```bash
git config --global user.name "Replace with your name"
git config --global user.email "replace_with_your_email@example.com"
```