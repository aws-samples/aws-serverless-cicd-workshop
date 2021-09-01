+++
title = "Invoke the canary"
date = 2021-08-30T08:30:00-06:00
weight = 10
+++

**While the deployment is running**, you need to generate traffic to the new Lambda function to make it fail and trigger the CloudWatch Alarm. In a real production environment, your users will likely generate organic traffic to the canary function, so you may not need to do this.

In your terminal, run the following command to invoke the Lambda function once:

```bash
aws lambda invoke --function-name \
$(aws cloudformation describe-stack-resource --stack-name sam-app --logical-resource-id HelloWorldFunction --query StackResourceDetail.PhysicalResourceId --output text):live \
--payload '{}' \
response.json
```

There will be a new file `response.json` created. It contains the response of the Lambda invocation. If you open it, you may see the the response of the old Lambda version, or you may see the new one that causes an error. 

**Remember:** During deployment, only 10% of the traffic will be routed to the new version. So, **keep on invoking your Lambda many times**. 1 out of 10 invocations should trigger the new broken Lambda, which is what you want to cause a rollback.

Here is a command that invokes your function 15 times in a loop. Feel free to run it in your terminal.

```bash
counter=1
helloworldfunction=`aws cloudformation describe-stack-resource --stack-name sam-app --logical-resource-id HelloWorldFunction --query StackResourceDetail.PhysicalResourceId --output text`
while [ $counter -le 15 ]
do
    aws lambda invoke --function-name $helloworldfunction:live --payload '{}' response.json
    sleep 1
    ((counter++))
done
```

Example with failure response:

![HelloWorldFunctionLoop](/images/python/canaries/helloworldfunction_unhandled.png)

