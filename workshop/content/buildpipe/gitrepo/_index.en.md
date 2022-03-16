+++
title = "Create a Git Repository"
date = 2019-10-03T15:26:06-07:00
weight = 5
+++

Any CI/CD pipeline starts with a code repository. In this workshop we use AWS CodeCommit. You could
use other source code integrations such as GitHub.

Run the following command from your terminal to create a new CodeCommit repository:

```bash
aws codecommit create-repository --repository-name sam-app
```

You should see output similar to the following:

```
admin:~/environment/sam-app $ aws codecommit create-repository --repository-name sam-app
{
    "repositoryMetadata": {
        "accountId": "111111111111",
        "repositoryId": "021cee6b-aaaa-0000-99999-6e2d5e9a7005",
        "repositoryName": "sam-app",
        "lastModifiedDate": 1631742708.328,
        "creationDate": 1631742708.328,
        "cloneUrlHttp": "https://git-codecommit.us-east-1.amazonaws.com/v1/repos/sam-app",
        "cloneUrlSsh": "ssh://git-codecommit.us-east-1.amazonaws.com/v1/repos/sam-app",
        "Arn": "arn:aws:codecommit:us-east-1:111111111111:sam-app"
    }
}
```
