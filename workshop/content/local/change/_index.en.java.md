+++
title = "Make a code change"
date = 2019-10-03T08:52:21-07:00
weight = 15
+++

Now lets make a simple code change. Press `CTRL-C` to terminate the running process.

![MakeCodeChange](/images/java/chapter2/change/terminate.png)

Open the file `sam-app/HelloWorldFunction/src/main/java/helloworld/App.java` change the response message to return `hello beautiful world` instead of _hello world_. Your Lambda handler should look like this after the change: 

![MakeCodeChange](/images/java/chapter2/change/hello-beautiful-world.png)

To see the new changes we must rebuild our SAM project

```
sam build
```

Build failure! This is expected as we haven't updated our unit tests.

![MakeCodeChange](/images/java/chapter2/change/test-failures.png)

In the next chapter we'll make the changes required to fix our build.