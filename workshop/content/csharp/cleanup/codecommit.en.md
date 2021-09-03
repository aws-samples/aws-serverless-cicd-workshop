+++
title = "Cleanup CodeCommit"
date = 2021-08-30T08:30:00-06:00
weight = 7
+++

Now that the pipeline is gone, we can delete the `sam-app` CodeCommit repository.

```bash
aws codecommit delete-repository --repository-name sam-app
```

After this, you can close the browser tab of your Cloud9 environment.