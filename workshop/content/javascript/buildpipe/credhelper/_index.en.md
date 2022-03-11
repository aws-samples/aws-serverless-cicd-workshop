+++
title = "Configure credentials"
date = 2019-10-03T16:26:02-07:00
weight = 10
+++

One of the cool things about CodeCommit is the support for IAM authentication. And if you are running this workshop from a Cloud9 workspace, you can leverage the fact that your terminal is already pre-authenticated with valid AWS credentials.

You can validate the Cloud9 git configuration with the following command:

```
git config --get-regexp credential\.*
```

You should see the following

```
credential.helper !aws codecommit credential-helper $@
credential.usehttppath true
```

If you are running this workshop outside Cloud9 or do **not** see the same credential configuation
above, refer to the [CodeCommit
Authentication](https://docs.aws.amazon.com/codecommit/latest/userguide/auth-and-access-control.html)
documentation.

Configure the git client with username and email, so your commits have an author defined.

```text
git config --global user.name "Replace with your name"
git config --global user.email "replace_with_your_email@example.com"
```
