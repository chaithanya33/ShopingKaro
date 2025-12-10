# Terraform (ShopingKaro)

This Terraform module provisions ECR, ECS (Fargate + ALB), CloudWatch Log Group, and Amazon DocumentDB using an existing VPC.
## Prerequisites
- Terraform 1.0+
- AWS account and credentials configured (environment variables, long-lived keys, or GitHub Actions OIDC)
## Quick start
1. cd terraform
2. terraform init
3. terraform plan \
	-var 'aws_region=us-east-1' \
	-var 'vpc_id=<vpc-id>' \
4. terraform apply (use the same -var flags as plan)
## Key variables and features
- `vpc_id`, `public_subnet_ids`, `private_subnet_ids` — supply your existing VPC and subnet IDs.
- `acm_certificate_arn` — ARN of an ACM certificate to enable HTTPS on the ALB.
- `route53_hosted_zone_id` and `route53_record_name` — When supplied, Terraform will create an Alias A record pointing the ALB to the given Route53 hosted zone. Omit or leave empty to skip DNS creation.
- `project_name` — prefix used for resource names and `Project` tag (default: `shopingkaro`).
- `environment` — tag value used for the `Environment` tag (default: `dev`).
- `log_retention_in_days` — retention for the CloudWatch Log Group created for ECS logs (default: 14).

## Tagging
- All supported resources created by this module include consistent tags via `local.common_tags`:
	- `Project = var.project_name`
	- `Environment = var.environment`

## CloudWatch Logs
- A CloudWatch Log Group named `/ecs/${var.project_name}` is created and used by the ECS task `awslogs` driver. The task definition does not attempt to auto-create the group (the provider creates it), avoiding runtime permission races.

## IAM
- The ECS execution role (`${var.project_name}-ecs-exec-role`) is used for execution tasks and receives an inline policy granting access to the S3 `env_file` object and permissions required for log handling. The task role (`${var.project_name}-ecs-task-role`) is separate and intended for application-level permissions.

## Notes and usage examples
- To create a DNS record for the ALB (example `app.example.com` in zone `Z123...`):

```bash
terraform plan \
	-var 'route53_hosted_zone_id=Z1234567890' \
	-var 'route53_record_name=app.example.com' \
	-var 'vpc_id=<vpc-id>' \
	-var 'public_subnet_ids=["subnet-aaa","subnet-bbb"]' \
	-var 'private_subnet_ids=["subnet-ccc","subnet-ddd"]'
terraform apply (with same vars)
```

- To change tagging environment (production/staging):

```bash
terraform plan -var 'environment=prod' ...
```

## Validation and formatting
- Run `terraform fmt` and `terraform validate` after editing variables or files:

```bash
cd terraform
terraform fmt
terraform init
terraform validate
```
