+++
title = "Invoke the canary"
date = 2019-11-12T13:21:47-08:00
weight = 10
+++

**While the deployment is running**, you need to generate traffic to the new Lambda function to make it fail and trigger the CloudWatch Alarm. In a real production environment, your users will likely generate organic traffic to the canary function, so you may not need to do this.

In your terminal, run the following command to invoke the Lambda function:

```
aws lambda invoke --function-name \
$(aws lambda list-functions | jq -r -c '.Functions[] | select( .FunctionName | contains("sam-app-HelloWorldFunction")).FunctionName'):live \
--payload '{}' \
response.json
```

{{% notice tip %}}
If you get an error that `jq` command is not installed, you can install it by running `sudo yum install -y jq`.
{{% /notice%}}

Example: 

![LambdaInvoke](/images/screenshot-lambda-invoke.png)

There will be a new file `response.json` created. It contains the response of the lambda invocation. If you open it, you may see the the response of the old Lambda version, or you may see the new one that causes an error. 

**Remember:** During deployment, only 10% of the traffic will be routed to the new version. So, **keep on invoking your lambda many times**. 1 out of 10 invocations should trigger the new broken lambda, which is what you want to cause a rollback.

Here is a command that invokes your function 15 times in a loop. Feel free to run it in your terminal.

```
counter=1
while [ $counter -le 15 ]
do
    aws lambda invoke --function-name \
    $(aws lambda list-functions | jq -r -c '.Functions[] | select( .FunctionName | contains("sam-app-HelloWorldFunction")).FunctionName'):live \
    --payload '{}' \
    response.json
    sleep 1
    ((counter++))
done
```