# How to use
- Create s3 bucket manually to save terraform state
- Update `apps/{env}/main.tf` using environment variables
- If update ecs_task_definition, need to deploy ecs manually
- Create ec2 ssh key-pair and repace public key in ec2 manually: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/replacing-key-pair.html
- You need to install libraries in bastion host manually if needed

# Script
```bash
cd apps/dev
cp ../env.tfvars terraform.tfvars # Update terraform.tfvars content
terraform init
terraform plan -out plan.out
# terraform plan -target=module.s3 -out plan.out
terraform apply plan.out
```

# TODO
- add ses
- add s3
- add cors to s3