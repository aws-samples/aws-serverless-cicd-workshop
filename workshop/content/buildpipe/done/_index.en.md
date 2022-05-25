+++
title = "Inspect pipeline"
date = 2019-11-05T14:20:52-08:00
weight = 35
+++

### Inspect the pipeline

Once the `sam-app-pipeline` CloudFormation stack has completed, you will have a new CodePipeline Pipeline.
Navigate to the [CodePipeline Console](https://console.aws.amazon.com/codesuite/codepipeline/pipelines).
You should see a single Pipeline. If you've navigated here soon after deploying the pipeline
CloudFormation stack, you will see your new Pipeline executing its first deployment.

![Pipeline in-progress](/images/chapter4-pipelines/sam-app-pipeline-in-progress.png)

Let your pipeline run every stage. After it finishes all stages will be green.

![Pipline stages in-progress](/images/chapter4-pipelines/sam-app-pipeline-2.png)

{{% notice note %}}
You may have noticed our `sam-app-dev` is deployed in a CodePipleine stage named `DeployTest`. The
`DeployTest` name is hardcoded in the `codepipeline.yaml` file and does not relate in any way to our
dev application that we named `sam-app-dev`. When you use this template outside this workshow you could
rename `DeployTest` to anything appropriate.
{{% /notice %}}

### Inspect the dev/prod stages

Nagivate to the CloudFormation console. After your first Pipeline has finished you will notice two
new stacks named `sam-app-dev` and `sam-app-prod`. These are the names you provided during the SAM
Pipelines wizard in the previous step.

CodeBuild created the `sam-app-dev` stack during the `DeployTest` Pipeline step. Similarly,
CodeBuild created `sam-app-prod` during the `DeployProd` step.

Look at the `Outputs` tab for each of these CloudFormation stacks to see the API endpoints. You can
use `curl` or other methods to verify the functionality of your two new APIs. You can export the URL
endpoints for both stages in a terminal.

```bash
export DEV_ENDPOINT=$(aws cloudformation describe-stacks --stack-name sam-app-dev | jq -r '.Stacks[].Outputs[].OutputValue | select(startswith("https://"))')
export PROD_ENDPOINT=$(aws cloudformation describe-stacks --stack-name sam-app-prod | jq -r '.Stacks[].Outputs[].OutputValue | select(startswith("https://"))')

echo "Dev endpoint: $DEV_ENDPOINT"
echo "Prod endpoint: $PROD_ENDPOINT"

curl -s $DEV_ENDPOINT
curl -s $PROD_ENDPOINT
```

![API endpoints](/images/chapter4-pipelines/sam-app-dev-cfn-outputs.png)

#### You may have noticed that unit tests are not being run in your pipeline. Let's fix that in the next section!
