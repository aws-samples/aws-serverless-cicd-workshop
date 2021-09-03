+++
title = "Install dotnet"
date = 2021-08-30T08:30:00-06:00
weight = 15
+++


{{% notice info %}}
If you are using Cloud9 and get an insufficent space or `ENOSPC: no space left on device` error, you may resize your volume by using the following commands from your Cloud9 terminal.
{{% /notice %}}
```bash
wget https://cicd.serverlessworkshops.io/assets/resize.sh
chmod +x resize.sh
./resize.sh 20
```

### dotnet

Follow these modified Step 2 and Step from [.NET Core sample for AWS Cloud9](https://docs.aws.amazon.com/cloud9/latest/user-guide/sample-dotnetcore.html) to install .Net Core

```
sudo yum -y update
sudo yum -y install libunwind
wget https://dot.net/v1/dotnet-install.sh
sudo chmod u=rx dotnet-install.sh
./dotnet-install.sh -c 3.1
nano ~/.bashrc
```

* append `:$HOME/.dotnet:$HOME/.dotnet/tools` to the export PATH= line
* add line for `export DOTNET_ROOT=$HOME/.dotnet`

```
. ~/.bashrc
dotnet --version
```