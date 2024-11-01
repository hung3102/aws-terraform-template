resource "aws_lb" "api" {
  client_keep_alive = "3600"

  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = "false"
  enable_cross_zone_load_balancing            = "true"
  enable_deletion_protection                  = "false"
  enable_http2                                = "true"
  enable_tls_version_and_cipher_suite_headers = "false"
  enable_waf_fail_open                        = "false"
  enable_xff_client_port                      = "false"
  idle_timeout                                = "60"
  internal                                    = "false"
  ip_address_type                             = "ipv4"
  load_balancer_type                          = "application"
  name                                        = "${var.prefix}-api"
  preserve_host_header                        = "false"
  security_groups                             = var.lb_sg_ids

  # subnet_mapping {
  #   subnet_id = "subnet-06c0d00c13c33ae4c"
  # }

  # subnet_mapping {
  #   subnet_id = "subnet-0833488a9092c4ad1"
  # }

  subnets                    = var.public_subnet_ids
  xff_header_processing_mode = "append"
}
