# AWS Website CI/CD Project

This project is a simple AWS-hosted static website with a visitor counter feature. It demonstrates how to deploy a front-end site to Amazon S3 and CloudFront, connect it to a serverless API, and automate deployment with GitHub Actions.

## What this project does

- Serves a static webpage from the `website/` folder.
- Displays a live visitor count fetched from an API endpoint.
- Uses AWS Lambda to update and return the count from DynamoDB.
- Provisions the supporting AWS infrastructure with Terraform.
- Deploys the site automatically to AWS when changes are pushed to the `main` branch.

## Architecture

The solution combines several AWS services:

- Amazon S3: stores the static website files.
- Amazon CloudFront: delivers the site globally with HTTPS.
- API Gateway: exposes an HTTP endpoint for the counter API.
- AWS Lambda: handles the counter update logic.
- Amazon DynamoDB: stores the visitor count.
- Terraform: provisions the AWS resources.
- GitHub Actions: automates deployment from GitHub to AWS.

## Project structure

```text
.
├── .github/
│   └── workflows/
│       └── deploy.yaml      # GitHub Actions deployment workflow
├── terraform/               # Terraform configuration for AWS resources
│   ├── acm.tf
│   ├── apigateway.tf
│   ├── cloudfront.tf
│   ├── dynamodb.tf
│   ├── iam.tf
│   ├── lambda.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── route53.tf
│   ├── s3.tf
│   ├── variables.tf
│   └── lambda/
│       └── lambda_function.py
└── website/                 # Static website files
    ├── index.html
    ├── script.js
    └── style.css
```

## How it works

1. The webpage in `website/` loads a JavaScript file that calls the API Gateway endpoint.
2. API Gateway routes the request to an AWS Lambda function.
3. The Lambda function increments the visitor count in a DynamoDB table.
4. The updated count is returned as JSON to the webpage.
5. The static site is published to S3 and cached through CloudFront.

## Infrastructure as Code

The Terraform files in `terraform/` define the AWS resources needed for this project. These include:

- S3 bucket for website hosting
- CloudFront distribution
- API Gateway HTTP API
- Lambda function
- IAM role and permissions
- DynamoDB table
- Optional DNS and ACM resources depending on your configuration

To deploy or update infrastructure, run Terraform from the `terraform/` directory:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## CI/CD deployment

The GitHub Actions workflow in `.github/workflows/deploy.yaml` deploys the contents of `website/` to the configured S3 bucket whenever changes are pushed to `main`.

It expects the following GitHub repository secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `S3_BUCKET`
- `CLOUDFRONT_DISTRIBUTION_ID`

## Local preview

You can preview the website locally by opening `website/index.html` in a browser, or by serving the folder with a simple local web server.

Example:

```bash
cd website
python3 -m http.server 8000
```

Then open `http://localhost:8000`.

## Notes

- The visitor counter is a simple example and is intended for learning and demonstration purposes.
- The Lambda function uses the AWS SDK for Python (`boto3`) to update DynamoDB.
- The project is designed to be easy to understand and extend.
