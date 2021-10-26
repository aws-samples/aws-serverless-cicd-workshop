+++
title = "Install dependencies"
date = 2021-08-30T08:30:00-06:00
weight = 5
+++

Before we run the application locally, it's a common practice to install third-party libraries or dependencies that your application might be using. These dependencies are defined in a file that varies depending on the runtime, for example _package.json_ for Node.js projects or _requirements.txt_ for Python ones.

In the terminal, go into the `sam-app/hello_world` folder and install the dependencies:

```bash
cd ~/environment/sam-app/hello_world
pip3 install -r requirements.txt
```

Example output:

```
Defaulting to user installation because normal site-packages is not writeable
Collecting requests
  Downloading requests-2.26.0-py2.py3-none-any.whl (62 kB)
     |████████████████████████████████| 62 kB 1.5 MB/s
Collecting charset-normalizer~=2.0.0
  Downloading charset_normalizer-2.0.9-py3-none-any.whl (39 kB)
Collecting certifi>=2017.4.17
  Downloading certifi-2021.10.8-py2.py3-none-any.whl (149 kB)
     |████████████████████████████████| 149 kB 15.2 MB/s
Collecting idna<4,>=2.5
  Downloading idna-3.3-py3-none-any.whl (61 kB)
     |████████████████████████████████| 61 kB 13.6 MB/s
Requirement already satisfied: urllib3<1.27,>=1.21.1 in /usr/local/lib/python3.7/site-packages (from requests->-r requirements.txt (line 1)) (1.26.7)
Installing collected packages: idna, charset-normalizer, certifi, requests
Successfully installed certifi-2021.10.8 charset-normalizer-2.0.9 idna-3.3 requests-2.26.0
```
