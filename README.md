# How to use
- Create s3 bucket manually to save terraform state
- Using aws `default` profile in local
- Update `apps/{env}/main.tf` using environment variables
- If update ecs_task_definition, need to deploy ecs manually
- Create ec2 ssh key-pair and repace public key in ec2 manually: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/replacing-key-pair.html
- Validate ACM certificate manually
- You need to install libraries in bastion host manually if needed
- Confirm billing alarm in email manually

# Script
```bash
cd apps/dev
cp ../env.tfvars terraform.tfvars # Update terraform.tfvars content
terraform init
terraform plan -out plan.out
# terraform plan -target=module.s3 -out plan.out
terraform apply plan.out
```