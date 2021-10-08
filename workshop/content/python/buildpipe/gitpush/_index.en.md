+++
title = "Push the code"
date = 2021-08-30T08:30:00-06:00
weight = 15
+++

### Ignore the build artifacts
Copy and paste the following lines at the end of the `sam-app/.gitgnore` file. There is no need to track the `.aws-sam` directory or the `packaged.yaml` under version control as they are re-generated on every build. 

```bash
.aws-sam/
packaged.yaml
```

Open the `.gitignore` file and paste the two lines described above. 

![GitIgnore](/images/python/buildpipe/cloud9_ide_gitignore.png) 

From the root directory of your _sam-app_ project, run the following commands:

{{% notice note %}}
The last command changes the default branch from `master` to `main` for this repository.  If your default branch is already configured as `main` you can skip that command. 
{{% /notice %}}

```bash
cd ~/environment/sam-app
git init
git add .
git commit -m "Initial commit"
git branch -m master main
```

Example: 
![GitCommit](/images/python/buildpipe/git_commands.png) 

### Push the code
Add your CodeCommit repository URL as a _remote_ on your local git project.

```bash
git remote add origin codecommit://sam-app
```

{{% notice tip %}}
If you typed the origin url incorrectly, you can remove it by running: `git remote rm origin`.
{{% /notice %}}

Now, push the code:

```bash
git push -u origin main
```

Example:

![GitPush](/images/python/buildpipe/git_push.png) 

### Verify in CodeCommit
Navigate to the [AWS CodeCommit console](https://console.aws.amazon.com/codesuite/codecommit/home), find your _sam-app_ repository and click on it to view its contents. Make sure your code is there. You should see a screen like the following:

![VerifyCodeCommit](/images/python/buildpipe/aws_console_codecommit.png) 