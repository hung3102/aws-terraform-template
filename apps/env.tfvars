aws_profile = "jb"
prefix = "tf-dev"

// ssm parameters
ssm_app_env ="dev"
ssm_cors="*"
ssm_api_url="http://localhost:3000"
ssm_db_user="yp_dev_user"
ssm_db_password="yp_dev_password"
ssm_no_reply_email="no_reply_email"
ssm_jwt_access_secret="jwt_access_secret"
ssm_jwt_refresh_secret="jwt_refresh_secret"


// ecs parameters
api_service_desired_count=1
api_container_cpu=256
api_container_ephemeral_storage_size=50
api_container_memory=512