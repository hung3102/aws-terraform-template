# How to use
- Create s3 bucket manually to save terraform state
- Update `apps/{env}/main.tf` using environment variables
- If update ecs_task_definition, need to deploy ecs manually

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