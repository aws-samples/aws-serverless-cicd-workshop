+++
title = "Install dependencies"
date = 2019-10-02T16:20:25-07:00
weight = 5
+++

Before we run the application locally, it's a common practice to install third-party libraries or
dependencies that your application might be using. These dependencies are defined in a file that
varies depending on the runtime, for example `package.json` for NodeJS projects or
`requirements.txt` for Python.

{{< tabs >}}
{{% tab name="Node" %}}

```
cd ~/environment/sam-app/hello-world
npm install
```

{{% /tab %}}
{{% tab name="python" %}}

```
cd ~/environment/sam-app/hello_world
pip3 install -r requirements.txt
```

{{% /tab %}}
{{% /tabs %}}

Example output:

{{< tabs >}}
{{% tab name="Node" %}}

```text
npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@~2.3.1 (node_modules/chokidar/node_modules/fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.3.2: wanted {"os":"darwin","arch":"any"} (current: {"os":"linux","arch":"x64"})

added 100 packages from 72 contributors and audited 101 packages in 3.879s

18 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```

{{% /tab %}}

{{% tab name="python" %}}

```text
Defaulting to user installation because normal site-packages is not writeable
Collecting requests
  Using cached requests-2.27.1-py2.py3-none-any.whl (63 kB)
Collecting certifi>=2017.4.17
  Using cached certifi-2021.10.8-py2.py3-none-any.whl (149 kB)
Collecting charset-normalizer~=2.0.0
  Using cached charset_normalizer-2.0.12-py3-none-any.whl (39 kB)
Requirement already satisfied: urllib3<1.27,>=1.21.1 in /usr/local/lib/python3.7/site-packages (from requests->-r requirements.txt (line 1)) (1.26.8)
Collecting idna<4,>=2.5
  Using cached idna-3.3-py3-none-any.whl (61 kB)
Installing collected packages: certifi, idna, charset-normalizer, requests
Successfully installed certifi-2021.10.8 charset-normalizer-2.0.12 idna-3.3 requests-2.27.1
```

{{% /tab %}}
{{% /tabs %}}
