prefix = "tf-dev"
environment = "development"

// ssm parameters
ssm_app_env ="dev"
ssm_cors="http://localhost:8081"
ssm_api_url="http://localhost:3000"
ssm_db_name="yp_dev_db"
ssm_db_user="yp_dev_user"
ssm_db_password="yp_dev_password"
ssm_no_reply_email="no_reply_email"
ssm_jwt_access_secret="jwt_access_secret"
ssm_jwt_refresh_secret="jwt_refresh_secret"
ssm_employer_url="http://localhost:8081"
ssm_admin_email="test@gmail.com"
ssm_scheduler_secret_token="scheduler_secret_token"
ssm_admin_token="your_admin_token_here"

// ecs parameters
api_service_desired_count=1
api_container_cpu=256
api_container_ephemeral_storage_size=50
api_container_memory=512

// rds parameters
rds_allocated_storage=20
rds_instance_class="db.t4g.micro"
rds_skip_final_snapshot=true

// ec2 parameters
bastion_host_instance_type="t2.micro"

// route53 parameters
domain_name="dev.example.com"
route53_records = {}

// billing alert
billing_alert_email="test@example.com"
billing_threshold=50 # USD

// admin api
admin_allowed_ips = [
  "192.168.1.1",
]