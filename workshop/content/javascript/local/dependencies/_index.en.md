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

```
admin:~/environment $ cd sam-app/hello-world
admin:~/environment/sam-app/hello-world $ npm install
npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@~2.3.1 (node_modules/chokidar/node_modules/fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.3.2: wanted {"os":"darwin","arch":"any"} (current: {"os":"linux","arch":"x64"})

added 100 packages from 72 contributors and audited 101 packages in 3.879s

18 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```
