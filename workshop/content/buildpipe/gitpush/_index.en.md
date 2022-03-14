+++
title = "Push the code"
date = 2019-10-03T16:22:07-07:00
weight = 15
+++

### Inititialize Git repository

Now we need to initialize a Git repository locally, add the code and push to the CodeCommit repository.

```
cd ~/environment/sam-app
git init -b main
echo -e "\n\n.aws-sam" >> .gitignore
git add .
git commit -m "Initial commit"
```

### Push the code

Add your CodeCommit repository URL as a _remote_ on your local git project.

```
git remote add origin codecommit://sam-app
```

{{% notice tip %}}
If you mis-typed the origin url, you can remove it by running: `git remote rm origin`.
{{% /notice %}}

Now, push the code:

```
git push -u origin main
```

Example output:

```text
Enumerating objects: 16, done.
Counting objects: 100% (16/16), done.
Delta compression using up to 2 threads
Compressing objects: 100% (12/12), done.
Writing objects: 100% (16/16), 25.37 KiB | 4.23 MiB/s, done.
Total 16 (delta 0), reused 0 (delta 0), pack-reused 0
To codecommit://sam-app
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

### Verify in CodeCommit

Navigate to the [AWS CodeCommit console](https://console.aws.amazon.com/codesuite/codecommit/home), find your _sam-app_ repository and click on it to view its contents. Make sure your code is there. You should see a screen like the following:

![VerifyCodeCommit](/images/screenshot-verify-codecommit.png)
