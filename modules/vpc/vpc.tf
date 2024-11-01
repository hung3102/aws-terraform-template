resource "aws_vpc" "main" {
  assign_generated_ipv6_cidr_block     = "false"
  cidr_block                           = "10.0.0.0/16"
  enable_dns_hostnames                 = "false"
  enable_dns_support                   = "true"
  enable_network_address_usage_metrics = "false"
  instance_tenancy                     = "default"

  tags = {
    Name = "${var.prefix}-main"
  }

  tags_all = {
    Name = "${var.prefix}-main"
  }
}
