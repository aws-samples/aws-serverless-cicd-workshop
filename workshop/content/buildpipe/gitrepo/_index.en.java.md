+++
title = "Create a Git Repository"
date = 2019-10-03T15:26:06-07:00
weight = 5
+++

Any CI/CD pipeline starts with a code repository. In this workshop we use AWS CodeCommit for ease of integration, but you could use other source code integrations, like GitHub for example. 

Run the following command from your terminal to create a new CodeCommit repository:

```
aws codecommit create-repository --repository-name sam-app
```

You should see the following output. Copy the value of `cloneUrlHttp`, you will need it later.

![CreateCodeCommit](/images/java/chapter4/gitrepo/create-repo.png) 