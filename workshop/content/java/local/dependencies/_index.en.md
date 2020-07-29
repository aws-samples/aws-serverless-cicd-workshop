+++
title = "Install dependencies"
date = 2019-10-02T16:20:25-07:00
weight = 5
+++

Before we run the application locally, it's a common practice to install third-party libraries or dependencies that your application might be using. In our case we need to upgrade Java and install Maven. 

Install OpenJDK 8. To do this, run the yum tool with the install command, specifying the OpenJDK 8 package.
```
sudo yum -y install java-1.8.0-openjdk-devel
```

Switch or upgrade the default Java development toolset to OpenJDK 8. To do this, run the update-alternatives command with the --config option. Run this command twice to switch or upgrade the command line versions of the Java runner and compiler.
```
sudo update-alternatives --config java
sudo update-alternatives --config javac
```

![NpmInstall](/images/java/chapter2/dependencies/java-alternatives.png)

Install Maven by using the terminal to run the following commands.
```
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/7/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
```

We can now use SAM to build our project
```
cd ~/environment/sam-app
sam build
```

Example: 

![NpmInstall](/images/java/chapter2/dependencies/sam-build.png)