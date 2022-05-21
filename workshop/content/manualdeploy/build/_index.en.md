+++
title = "Build the app"
date = 2019-10-03T11:25:04-07:00
weight = 10
+++

To build a SAM project, we are going to use the `sam build` command. This command iterates through
the functions in your application, looking for the manifest file (such as `requirements.txt` or
`package.json`) that contain dependencies and automatically creates deployment artifacts.

From the root of the `sam-app` folder, run the following command in the terminal:

```bash
cd ~/environment/sam-app
sam build
```

{{< tabs >}}
{{% tab name="Node" %}}

```text
Building codeuri: /home/ec2-user/environment/sam-app/hello-world runtime: nodejs16.x metadata: {} architecture: x86_64 functions: ['HelloWorldFunction']
Running NodejsNpmBuilder:NpmPack
Running NodejsNpmBuilder:CopyNpmrc
Running NodejsNpmBuilder:CopySource
Running NodejsNpmBuilder:NpmInstall
Running NodejsNpmBuilder:CleanUpNpmrc
Running NodejsNpmBuilder:LockfileCleanUp

Build Succeeded

Built Artifacts  : .aws-sam/build
Built Template   : .aws-sam/build/template.yaml

Commands you can use next
=========================
[*] Invoke Function: sam local invoke
[*] Test Function in the Cloud: sam sync --stack-name {stack-name} --watch
[*] Deploy: sam deploy --guided
```

{{% /tab %}}
{{% tab name="python" %}}

```text
Building codeuri: /home/ec2-user/environment/sam-app/hello_world runtime: python3.7 metadata: {} architecture: x86_64 functions: ['HelloWorldFunction']
Running PythonPipBuilder:ResolveDependencies
Running PythonPipBuilder:CopySource
Build Succeeded

Built Artifacts  : .aws-sam/build
Built Template   : .aws-sam/build/template.yaml

Commands you can use next
=========================
[*] Invoke Function: sam local invoke
[*] Test Function in the Cloud: sam sync --stack-name {stack-name} --watch
[*] Deploy: sam deploy --guided
```

{{% /tab %}}
{{% /tabs %}}

### Build completed

When the build finishes successfully, you will see a new directory created in the root of the
project named `.aws-sam`. It is a hidden folder, so if you want to see it in the IDE, **make sure
you enable `Show hidden files` in Cloud9** to see it.

![SamBuild](/images/screenshot-sam-build.png)

### Explore the build folder

Take a moment to explore the content of the build folder. Notice that the unit tests are
automatically excluded and 3rd party dependencies are _included_. SAM is taking care of all of this
for us.

![SamBuildFolder](/images/screenshot-sam-build-folder.png)

{{< tabs >}}
{{% tab name="Node" %}}

```text
admin:~/environment/node-sam-app $ ls -l .aws-sam/build/HelloWorldFunction/
total 8
-rw-r--r-- 1 ec2-user ec2-user 331 Oct 26  1985 app.js
drwxrwxr-x 5 ec2-user ec2-user  57 Mar  9 22:35 node_modules
-rw-r--r-- 1 ec2-user ec2-user 468 Oct 26  1985 package.json
```

{{% /tab %}}
{{% tab name="python" %}}

```text
admin:~/environment/sam-app $ ls -l .aws-sam/build/HelloWorldFunction/
total 12
-rw-rw-r-- 1 ec2-user ec2-user  175 Mar  9 21:55 app.py
drwxrwxr-x 2 ec2-user ec2-user   77 Mar  9 22:35 certifi
drwxrwxr-x 2 ec2-user ec2-user   85 Mar  9 22:35 certifi-2021.10.8.dist-info
drwxrwxr-x 4 ec2-user ec2-user  193 Mar  9 22:35 charset_normalizer
drwxrwxr-x 2 ec2-user ec2-user  109 Mar  9 22:35 charset_normalizer-2.0.12.dist-info
drwxrwxr-x 2 ec2-user ec2-user  171 Mar  9 22:35 idna
drwxrwxr-x 2 ec2-user ec2-user   88 Mar  9 22:35 idna-3.3.dist-info
-rw-rw-r-- 1 ec2-user ec2-user    0 Mar  8 16:07 __init__.py
drwxrwxr-x 2 ec2-user ec2-user 4096 Mar  9 22:35 requests
drwxrwxr-x 2 ec2-user ec2-user   85 Mar  9 22:35 requests-2.27.1.dist-info
-rw-rw-r-- 1 ec2-user ec2-user    8 Mar  8 16:07 requirements.txt
drwxrwxr-x 5 ec2-user ec2-user  272 Mar  9 22:35 urllib3
drwxrwxr-x 2 ec2-user ec2-user   89 Mar  9 22:35 urllib3-1.26.8.dist-info
```

{{% /tab %}}
{{% /tabs %}}
