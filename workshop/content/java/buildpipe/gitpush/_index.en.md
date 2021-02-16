+++
title = "Push the code"
date = 2019-10-03T16:22:07-07:00
weight = 15
+++

### Ignore the build artifacts
There is no need to track the  .aws-sam directory or the packaged.yaml under version control as they are re-generated on every build. We will paste the following into a `.gitgnore` file. 

Create the file

```
cd ~/environment/sam-app
touch .gitignore
```

In Cloud9, remember to enable hidden files: 

![EnableHiddenFiles](/images/java/chapter4/gitpush/enable-hidden-files.png)

Open the `.gitignore` file and paste the two lines below. 

```
.aws-sam/
packaged.yaml
```

Remember to save the file (File> Save or CMD +S etc)

![GitIgnore](/images/java/chapter4/gitpush/git-ignore.png)

From the root directory of your _sam-app_ project, run the following commands:

```
cd ~/environment/sam-app
git init
git add .
git commit -m "Initial commit"
```

Example: 
![GitCommit](/images/java/chapter4/gitpush/initial-commit.png)

### Push the code
Add your CodeCommit repository URL as a _remote_ on your local git project.

```
git remote add origin codecommit://sam-app
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

![VerifyCodeCommit](/images/java/chapter4/gitpush/code-commit.png)
