+++
title = "Install dependencies"
date = 2019-10-02T16:20:25-07:00
weight = 5
+++

Before we run the application locally, it's a common practice to install third-party libraries or dependencies that your application might be using. These dependencies are defined in a file that varies depending on the runtime, for example _package.json_ for NodeJS projects or _requirements.txt_ for Python ones. 

In the terminal, go into the `sam-app/hello-world` folder.
```
cd sam-app/hello-world
```

And install the dependencies:
```
npm install
```

Example: 

![NpmInstall](/images/screenshot-npm-install.png)