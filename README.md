# AWS Terraform Infrastructure

This repository contains Terraform configurations for setting up a comprehensive AWS infrastructure for demo applications hosted in EKS. It includes configurations for VPC, EKS, RDS, IAM roles, CodeBuild, CodePipeline, and other resources.

## Table of Contents

- [Architecture](#architecture)
- [Pre-requisites](#pre-requisites)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Variables](#variables)
- [Outputs](#outputs)
- [Contributing](#contributing)
- [License](#license)

## Architecture

The Terraform configurations in this repository will create the following AWS infrastructure:

1. **VPC**: A Virtual Private Cloud with subnets, route tables, and an internet gateway.
2. **EKS**: Amazon Elastic Kubernetes Service for running Kubernetes clusters.
3. **RDS**: Amazon Relational Database Service for MySQL databases.
4. **ECR**: Amazon Elastic Container Registry for storing Docker images.
5. **IAM Roles**: Roles for various AWS services.
6. **CodeBuild**: Projects for building Docker images.
7. **CodePipeline**: Pipelines for CI/CD.
8. **S3**: Buckets for storing CodePipeline artifacts.
9. **Kubernetes**: Namespace, deployment, service, and RBAC for NGINX ingress controller.

## Pre-requisites

- [Terraform](https://www.terraform.io/downloads.html) installed.
- AWS account with appropriate permissions.
- GitHub OAuth token with repo access.

## Usage

1. **Clone the repository**:
    ```sh
    git clone https://github.com/your-username/aws-terraform-infrastructure.git
    cd aws-terraform-infrastructure
    ```

2. **Configure AWS credentials**:
    Ensure your AWS credentials are configured. This can be done via environment variables or AWS CLI.

3. **Create `terraform.tfvars`**:
    Create a `terraform.tfvars` file to store your sensitive information (make sure this file is in `.gitignore`):
    ```hcl
    db_host       = "your_db_host"
    db_user       = "your_db_user"
    db_password   = "your_db_password"
    db_name       = "your_db_name"
    docker_username = "your_docker_username"
    docker_password = "your_docker_password"
    github_token  = "your_github_token"
    ```

4. **Initialize Terraform**:
    ```sh
    terraform init
    ```

5. **Apply Terraform configurations**:
    ```sh
    terraform apply
    ```

## Folder Structure

```plaintext
.
├── README.md
├── aws-auth-config.tf
├── codebuild.tf
├── codepipeline.tf
├── ecr.tf
├── eks.tf
├── iam.tf
├── nginx_ingress.tf
├── parameters.tf
├── provider.tf
├── rds.tf
├── s3.tf
├── variables.tf
├── vpc.tf
├── .gitignore
└── terraform.tfvars

## Variables

| Variable         | Description                       | Type   | Sensitive |
|------------------|-----------------------------------|--------|-----------|
| `db_host`        | Database host                     | string | true      |
| `db_user`        | Database user                     | string | true      |
| `db_password`    | Database password                 | string | true      |
| `db_name`        | Database name                     | string | true      |
| `docker_username`| Docker username                   | string | true      |
| `docker_password`| Docker password                   | string | true      |
| `github_token`   | OAuth token for GitHub            | string | true      |

## Outputs

| Output        | Description                    |
|---------------|--------------------------------|
| `rds_endpoint`| The endpoint of the RDS instance |


## License

This project is licensed under the MIT License.
