+++
title = "Push the code"
date = 2019-10-03T16:22:07-07:00
weight = 15
+++

### Ignore the build artifacts
Copy and paste the following lines at the end of the `sam-app/.gitgnore` file. There is no need to track the  .aws-sam directory or the packaged.yaml under version control as they are re-generated on every build. 

```
.aws-sam/
packaged.yaml
```

In Cloud9, remember to enable hidden files: 

![EnableHiddenFiles](/images/screenshot-hidden-files-cloud9.png)

Open the `.gitignore` file and paste the two lines described above. 

![GitIgnore](/images/screenshot-git-ignore.png)

From the root directory of your _sam-app_ project, run the following commands:

```
cd ~/environment/sam-app
git init
git add .
git commit -m "Initial commit"
```

Example: 
![GitCommit](/images/screenshot-git-commit.png)

### Push the code
Add your CodeCommit repository URL as a _remote_ on your local git project. This is the `cloneUrlHttp` value that you got back after creating the repository in Step 1 of this chapter.

{{% notice tip %}}
If you can't find the CodeCommit repository URL, you can find it by running this command: `aws codecommit get-repository --repository-name sam-app`.
{{% /notice %}}

```
git remote add origin REPLACE_WITH_HTTP_CLONE_URL
```

{{% notice tip %}}
If you typed the origin url incorrectly, you can remove it by running: `git remote rm origin`.
{{% /notice %}}

Now, push the code:

```
git push -u origin master
```

Example:

![GitPush](/images/screenshot-git-push.png)

### Verify in CodeCommit
Navigate to the [AWS CodeCommit console](https://console.aws.amazon.com/codesuite/codecommit/home), find your _sam-app_ repository and click on it to view its contents. Make sure your code is there. You should see a screen like the following:

![VerifyCodeCommit](/images/screenshot-verify-codecommit.png)