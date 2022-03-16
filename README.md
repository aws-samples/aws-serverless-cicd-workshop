# CI/CD for Serverless Applications Workshop

In this workshop, you will learn how to start a new Serverless application from scratch using the 
AWS Serverless Application Model (AWS SAM) and how to fully automate builds and deployments. You
will bootstrap a fully-automated CI/CD pipeline using 
[SAM Pipelines](https://aws.amazon.com/blogs/compute/introducing-aws-sam-pipelines-automatically-generate-deployment-pipelines-for-serverless-applications/). 
At the end of the workshop you will have a self-updating pipeline which 

1. Deploys two stages, `dev` and `prod`
1. Runs unit tests
1. Deploys gradually using canary deployments
1. Monitors for errors
1. Aborts deployments when errors occur

You will also learn how to run a Serverless application locally using the SAM CLI

![Image](workshop/static/images/github-home.svg)

## Getting Started

Visit the workshop on this URL: [https://cicd.serverlessworkshops.io](https://cicd.serverlessworkshops.io)

## Older workshop versions

This workshop has been evolving thanks to community contributions. We keep older versions for those
who prefer different approaches for creating CI/CD pipelines.
Every major update, we create a branch with the old version and make it available in the following URLs:

| Version  | Description | URL |
| ------------- | ------------- | ------------- |
| v1  | Raw cloudformation, no CDK  | [https://v1.cicd.serverlessworkshops.io](https://v1.cicd.serverlessworkshops.io) |
| v2  | No multi-language, javascript only | [https://v2.cicd.serverlessworkshops.io](https://v2.cicd.serverlessworkshops.io) |
| v3  | CDK, without SAM Pipelines | [https://v3.cicd.serverlessworkshops.io](https://v3.cicd.serverlessworkshops.io) |

## Want to contribute?

Check our [contribution guidelines](CONTRIBUTING.md) before submitting a pull request.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

