# AWS Website CI/CD Project

This project is a simple AWS-hosted static website with a visitor counter. It shows how to deploy a front-end app to Amazon S3 and CloudFront, connect it to a serverless API, and automate deployments with GitHub Actions.

## What it does

- Serves the website from the `website/` folder.
- Fetches a visitor count from an API endpoint.
- Uses AWS Lambda and DynamoDB to update and store that count.
- Provisions the AWS resources with Terraform.

## Architecture

The app uses:

- Amazon S3 for static website storage
- Amazon CloudFront for global delivery
- API Gateway for the HTTP endpoint
- AWS Lambda for the counter logic
- Amazon DynamoDB for persistent counting
- Terraform for infrastructure as code

## Project structure

```text
.
├── .github/workflows/deploy.yaml
├── terraform/            # AWS infrastructure definitions
├── website/              # Static website files
└── README.md
```

## How it works

1. The webpage calls the API Gateway endpoint from JavaScript.
2. API Gateway forwards the request to AWS Lambda.
3. Lambda updates the DynamoDB item and returns the new count.
4. The page displays the returned value.
5. The static site is published to S3 and served through CloudFront.

## CI/CD pipeline

The GitHub Actions workflow in `.github/workflows/deploy.yaml` runs on pushes to the `main` branch.

It performs two main steps:

- Configures AWS credentials from GitHub secrets.
- Uploads the website files to the target S3 bucket and invalidates the CloudFront cache.

Required repository secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `S3_BUCKET`
- `CLOUDFRONT_DISTRIBUTION_ID`

## Infrastructure deployment

From the `terraform/` directory, run:

```bash
terraform init
terraform plan
terraform apply
```

## Local preview

Run:

```bash
cd website
python3 -m http.server 8000
```

Then open `http://localhost:8000`.
